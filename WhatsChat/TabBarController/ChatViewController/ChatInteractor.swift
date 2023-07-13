import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ChatInteracting: AnyObject {
    func addListenerLoadMessage()
    func sendMessage(message: String)
    func removeListener()
}

final class ChatInteractor: ChatInteracting {
    private let presenter: ChatPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var currentUserID = ""
    private var contactData: UserViewModel?
    private var messageList: [MessageViewModel] = []
    private var messageListener: ListenerRegistration?
    
    
    init(presenter: ChatPresenting, viewModel: UserViewModel) {
        self.presenter = presenter
        self.contactData = viewModel
        print(viewModel.name)
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
        var sender = true
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
                        guard let safeCurrentID = data["userID"] as? String,
                              let safeText = data["text"] as? String else {return}
                        if self.currentUserID == safeCurrentID {
                            sender = true
                        } else {
                            sender = false
                        }
                        self.messageList.append(MessageViewModel(userID: safeCurrentID, text: safeText, isSenderCurrentUser: true))
                    }
                    
                    self.presenter.loadMessages(messages: self.messageList)
                }
                )}
    }
 
    func removeListener() {
        messageListener?.remove()
        presenter.removeListener()
    }
}


class MessageViewModel {
    let userID: String?
    let text: String?
  //  let date: String?
    let isSenderCurrentUser: Bool
    
    init(userID: String, text: String, isSenderCurrentUser: Bool) {
        self.userID = userID
        self.text = text
      //  self.date = date
        self.isSenderCurrentUser = isSenderCurrentUser
    }
}
