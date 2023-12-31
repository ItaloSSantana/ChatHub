import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

protocol ContactsInteracting: AnyObject {
    func loadData()
    func addPressed()
    func searchPressed(text: String)
    func contactChat(sender: ContactViewModel)
    func removeListener()
}

final class ContactsInteractor: ContactsInteracting {
    private let presenter: ContactsPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var currentUserID = ""
    private var contactList: [ContactViewModel] = []
    private var messageListener: ListenerRegistration?
    
    init(presenter: ContactsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
        storage = Storage.storage()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
    }
    //Load data from database
    func loadData() {
        contactList.removeAll()
        presenter.isLoadEnabled(verify: true)
        messageListener = firestore?.collection("users")
            .document(currentUserID)
            .collection("contacts")
            .order(by: "name", descending: true)
            .addSnapshotListener({ (resultSnapshot, error) in
                guard let snapshot = resultSnapshot else {
                    print("cannot get user")
                    return}
                snapshot.documents.forEach { (document) in
                    let contactData = document.data()
                    guard let safeName = contactData["name"] as? String,
                          let safeEmail = contactData["email"] as? String,
                          let safeBio = contactData["bio"] as? String,
                          let safeUrl = contactData["imageUrl"] as? String,
                          let safeId = contactData["id"] as? String else {return}
                    self.contactList.append(ContactViewModel(name: safeName,
                                                             email: safeEmail,
                                                             image: safeUrl,
                                                             bio: safeBio,
                                                             id: safeId))
                    self.presenter.displayScreen(contacts: self.contactList)
                    self.presenter.isLoadEnabled(verify: false)
                    
                }
            })
    }
    
    func removeListener() {
        messageListener?.remove()
    }
    
    func searchPressed(text: String) {
        let filterList = contactList
        self.contactList.removeAll()
        filterList.forEach { (item) in
            if item.name.lowercased().contains(text.lowercased()) {
                self.contactList.append(item)
            }
        }
        self.presenter.displayScreen(contacts: self.contactList)
    }
    
    func contactChat(sender: ContactViewModel) {
        presenter.contactChat(sender: sender)
    }
    
    func addPressed() {
        presenter.addPressed()
    }
    
}



