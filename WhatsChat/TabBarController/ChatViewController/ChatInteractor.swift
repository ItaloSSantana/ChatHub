import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol ChatInteracting: AnyObject {
    func addListenerLoadMessage()
    func sendMessage(message: String)
    func removeListener()
    func sendImage(image: UIImage)
}

final class ChatInteractor: ChatInteracting {
    private let presenter: ChatPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var currentUserID = ""
    private var contactData: UserViewModel?
    private var messageList: [MessageViewModel] = []
    private var messageListener: ListenerRegistration?
    private var storage: Storage?
    
    
    init(presenter: ChatPresenting, viewModel: UserViewModel) {
        self.presenter = presenter
        self.contactData = viewModel
        storage = Storage.storage()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
    }
    
    func sendMessage(message: String) {
        if !message.isEmpty {
            if let safeContact = contactData {
                let msg: Dictionary<String, Any> = [
                    "userID" : currentUserID,
                    "text" : message,
                    "date" : FieldValue.serverTimestamp()
                ]
                saveMessage(currentID: currentUserID, contactID: safeContact.id, message: msg)
                saveMessage(currentID: safeContact.id, contactID: currentUserID, message: msg)
                self.presenter.sendMessage()
            }
        }
    }
    
    private func saveMessage(currentID: String, contactID: String, message: Dictionary<String, Any>) {
        firestore?.collection("messages")
            .document(currentID)
            .collection(contactID)
            .addDocument(data: message)
    }
    
    
    func addListenerLoadMessage() {
        var sender = false
        if let contactID = contactData?.id {
            messageListener = firestore?.collection("messages")
                .document(currentUserID)
                .collection(contactID)
                .order(by: "date", descending: false)
                .addSnapshotListener({ (querySnapshot, error) in
                    self.messageList.removeAll()
                    guard let snapshot = querySnapshot else {return}
                    snapshot.documents.forEach { (document) in
                        let data = document.data()
                        var viewModel: MessageViewModel?
                        guard let safeCurrentID = data["userID"] as? String else {return}
                        if self.currentUserID == safeCurrentID {
                            sender = true
                        } else {
                            sender = false
                        }
                        if let safeText = data["text"] as? String {
                            viewModel = MessageViewModel(userID: safeCurrentID, text: safeText, imageUrl: nil, isSenderCurrentUser: sender)
                        }
                        if let safeImage = data["imageUrl"] as? String {
                            viewModel = MessageViewModel(userID: safeCurrentID, text: nil, imageUrl: safeImage, isSenderCurrentUser: sender)
                        }
                        guard let safeViewModel = viewModel else {return}
                        self.messageList.append(safeViewModel)
                    }
                    
                    self.presenter.loadMessages(messages: self.messageList)
                }
                )}
    }
    
    func sendImage(image: UIImage) {
        let images = storage?.reference().child("images")
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else {return}
        let uniqueID = UUID().uuidString
        let imageName = ("\(uniqueID).jpg")
        guard let messageImageRef = images?.child("messages").child(imageName) else {return}
        messageImageRef.putData(uploadImage, metadata: nil) { (metadata, error) in
            if error == nil {
                print("uploaded image")
                messageImageRef.downloadURL { (url, error) in
                    guard let imageUrl = url?.absoluteString else {return}
                    if let safeContact = self.contactData {
                        let msg: Dictionary<String, Any> = [
                            "userID" : self.currentUserID,
                            "imageUrl" : imageUrl,
                            "date" : FieldValue.serverTimestamp()
                        ]
                        self.saveMessage(currentID: self.currentUserID, contactID: safeContact.id, message: msg)
                        self.saveMessage(currentID: safeContact.id, contactID: self.currentUserID, message: msg)
                        //self.presenter.sendMessage()
                        print("Imagem enviada")
                    }
                }
            } else {
                print("Not upload image")
            }
        }
    }
 
    func removeListener() {
        messageListener?.remove()
        presenter.removeListener()
    }
}


class MessageViewModel {
    let userID: String?
    let text: String?
    let imageUrl: String?
    let isSenderCurrentUser: Bool
    
    init(userID: String, text: String?, imageUrl: String?, isSenderCurrentUser: Bool) {
        self.userID = userID
        self.text = text
        self.imageUrl = imageUrl
        self.isSenderCurrentUser = isSenderCurrentUser
    }
}
