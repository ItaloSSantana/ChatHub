import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol MessagesInteracting: AnyObject {
    func loadLastMessage()
    func removeListener()
}

final class MessagesInteractor: MessagesInteracting {
    private let presenter: MessagesPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var currentUserID = ""
    private var messageListener: ListenerRegistration?
    private var messagesList: [MessagesViewModel] = []
    
    init(presenter: MessagesPresenting) {
        self.presenter = presenter
        storage = Storage.storage()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
    }
    
    func loadLastMessage() {
        messageListener = firestore?.collection("chats")
            .document(currentUserID)
            .collection("lastMessage")
            .addSnapshotListener({ (querySnapshot, error) in
                self.messagesList.removeAll()
                guard let snapshot = querySnapshot else {return}
                snapshot.documents.forEach { document in
                    let messagesData = document.data()
                    guard let safeUserID = messagesData["userID"] as? String,
                          let safeContactId = messagesData["contactID"] as? String,
                          let safeContactName = messagesData["contactName"] as? String,
                          let safeContactPhotoUrl = messagesData["contactPhotoUrl"] as? String,
                          let safeLastMessage = messagesData["lastMessage"] as? String else {return}
                    self.messagesList.append(MessagesViewModel(userID: safeUserID,
                                                               contactID: safeContactId,
                                                               contactName: safeContactName,
                                                               contactPhotoUrl: safeContactPhotoUrl,
                                                               lastMessage: safeLastMessage))
                    self.presenter.loadLastMessage(messages: self.messagesList)
                }
            })
    }
    
    func removeListener() {
        messageListener?.remove()
    }
}

class MessagesViewModel {
    let userID: String
    let contactID: String
    let contactName: String
    let contactPhotoUrl: String
    let lastMessage: String
    
    init(userID: String, contactID: String,  contactName: String, contactPhotoUrl: String, lastMessage: String) {
        self.userID = userID
        self.contactID = contactID
        self.contactName = contactName
        self.contactPhotoUrl = contactPhotoUrl
        self.lastMessage = lastMessage
    }
}
