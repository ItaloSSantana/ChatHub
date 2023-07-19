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
    private var storage: Storage?
    private var contactData: ContactViewModel?
    private var messageList: [ChatViewModel] = []
    private var messageListener: ListenerRegistration?
    
    private var currentUserID = ""
    private var currentUserName = ""
    private var currentUserImageUrl = ""
    
    init(presenter: ChatPresenting, viewModel: ContactViewModel) {
        self.presenter = presenter
        self.contactData = viewModel
        storage = Storage.storage()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
        getCurrentUserData()
        
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

                var chat: Dictionary<String, Any> = [
                    "lastMessage": message
                ]
                chat["userID"] = currentUserID as Any
                chat["contactID"] = safeContact.id as Any
                chat["contactName"] = contactData?.name as Any
                chat["contactPhotoUrl"] = contactData?.image as Any
                saveChat(currentID: currentUserID, contactID: safeContact.id, chat: chat)
                
                chat["userID"] = safeContact.id as Any
                chat["contactID"] = currentUserID as Any
                chat["contactName"] = currentUserName
                chat["contactPhotoUrl"] = currentUserImageUrl
                saveChat(currentID: safeContact.id, contactID: currentUserID, chat: chat)
                self.presenter.sendMessage()
            }
        }
    }
    
    private func getCurrentUserData() {
        firestore?.collection("users")
            .document(currentUserID)
            .getDocument(completion: { (snapshot, error) in
                guard let safeData = snapshot?.data(),
                      let safeName = safeData["name"] as? String,
                      let safeUrl = safeData["imageUrl"] as? String else {return}
                self.currentUserName = safeName
                self.currentUserImageUrl = safeUrl
            })
    }
    
    private func saveMessage(currentID: String, contactID: String, message: Dictionary<String, Any>) {
        firestore?.collection("messages")
            .document(currentID)
            .collection(contactID)
            .addDocument(data: message)
    }
    
    private func saveChat(currentID: String, contactID: String, chat: Dictionary<String, Any>) {
        firestore?.collection("chats")
            .document(currentID)
            .collection("lastMessage")
            .document(contactID)
            .setData(chat)
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
                        var viewModel: ChatViewModel?
                        guard let safeCurrentID = data["userID"] as? String else {return}
                        if self.currentUserID == safeCurrentID {
                            sender = true
                        } else {
                            sender = false
                        }
                        if let safeText = data["text"] as? String {
                            viewModel = ChatViewModel(userID: safeCurrentID, text: safeText, imageUrl: nil, isSenderCurrentUser: sender)
                        }
                        if let safeImage = data["imageUrl"] as? String {
                            viewModel = ChatViewModel(userID: safeCurrentID, text: nil, imageUrl: safeImage, isSenderCurrentUser: sender)
                        }
                        guard let safeViewModel = viewModel else {return}
                        self.messageList.append(safeViewModel)
                    }
                    self.presenter.loadMessages(messages: self.messageList)
                    if let contactName = self.contactData?.name {
                        self.presenter.loadContactName(name: contactName)
                    }
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
                messageImageRef.downloadURL { (url, error) in
                    guard let imageUrl = url?.absoluteString else {return}
                    if let safeContact = self.contactData {
                        
                        // Save to Message Screen (chat screen)
                        let msg: Dictionary<String, Any> = [
                            "userID" : self.currentUserID,
                            "imageUrl" : imageUrl,
                            "date" : FieldValue.serverTimestamp()
                        ]
                        
                        self.saveMessage(currentID: self.currentUserID, contactID: safeContact.id, message: msg)
                        self.saveMessage(currentID: safeContact.id, contactID: self.currentUserID, message: msg)
                        
                        // Save to Messages screen
                        var chat: Dictionary<String, Any> = [
                            "userID": self.currentUserID,
                            "contactID": safeContact.id,
                            "lastMessage": "Image..."
                        ]
                        chat["userID"] = self.currentUserID as Any
                        chat["contactID"] = safeContact.id as Any
                        chat["contactName"] = self.contactData?.name as Any
                        chat["contactPhotoUrl"] = self.contactData?.image as Any
                        self.saveChat(currentID: self.currentUserID, contactID: safeContact.id, chat: chat)
                        
                        chat["userID"] = safeContact.id as Any
                        chat["contactID"] = self.currentUserID as Any
                        chat["contactName"] = self.currentUserName
                        chat["contactPhotoUrl"] = self.currentUserImageUrl
                        self.saveChat(currentID: safeContact.id, contactID: self.currentUserID, chat: chat)
                        self.presenter.sendMessage()
                    }
                }
            } else {
                print("Not upload image")
            }
        }
    }
    
    func removeListener() {
        messageListener?.remove()
    }
}

