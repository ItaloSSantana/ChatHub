import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol MessagesInteracting: AnyObject {
    func loadLastMessage()
    func contactChat(contactData: ContactViewModel)
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
    // Load last messages
    func loadLastMessage() {
        loadCurrentUserData()
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
    // Load current user
    func loadCurrentUserData() {
        firestore?.collection("users")
            .document(currentUserID)
            .getDocument(completion: { (querySnapshot, error) in
                guard let snapshot = querySnapshot else {return}
                guard let data = snapshot.data(),
                      let safeName = data["name"] as? String,
                      let safeImageUrl = data["imageUrl"] as? String,
                      let safeBio = data["bio"] as? String else {return}
                let currentUserData = ContactViewModel(name: safeName, email: "", image: safeImageUrl, bio: safeBio, id: "")
                self.presenter.loadCurrentUserData(userData: currentUserData)
            })
    }
    
    func contactChat(contactData: ContactViewModel) {
        presenter.contactChat(contactData: contactData)
    }
    
    func removeListener() {
        messageListener?.remove()
    }
}




