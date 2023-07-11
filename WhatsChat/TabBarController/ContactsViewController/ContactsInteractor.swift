import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

protocol ContactsInteracting: AnyObject {
    func loadData()
    func addPressed()
    func searchPressed(text: String)
    func contactChat(sender: UserViewModel)
}

final class ContactsInteractor: ContactsInteracting {
    private let presenter: ContactsPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var currentUserID = ""
    private var contactList: [UserViewModel] = []
    
    init(presenter: ContactsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
        storage = Storage.storage()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
    }
    
    func loadData() {
        contactList.removeAll()
        presenter.isLoadEnabled(verify: true)
        firestore?.collection("users")
            .document(currentUserID)
            .collection("contacts")
            .getDocuments(completion: { (resultSnapshot, error) in
                guard let snapshot = resultSnapshot else {
                    print("cannot get user")
                    return}
                snapshot.documents.forEach { (document) in
                    let contactData = document.data()
                    guard let safeName = contactData["name"] as? String,
                          let safeEmail = contactData["email"] as? String,
                          let safeBio = contactData["bio"] as? String,
                          let safeUrl = contactData["imageUrl"] as? String,
                          let safeId = contactData["id"] as? String,
                          let storageRef = self.storage?.reference(forURL: safeUrl) else {return}
                    storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) -> Void in
                        guard let safeData = data else {return}
                        if let safeImage = UIImage(data: safeData) {
                            self.contactList.append(UserViewModel(name: safeName, email: safeEmail, image: safeImage, bio: safeBio, id: safeId))
                        }
                        self.presenter.displayScreen(contacts: self.contactList)
                        self.presenter.isLoadEnabled(verify: false)
                    }
                }
            })
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
    
    func contactChat(sender: UserViewModel) {
        presenter.contactChat(sender: sender)
    }
    
    func addPressed() {
        presenter.addPressed()
    }
    
}

class UserViewModel {
    let name: String
    let email: String
    let image: UIImage?
    let bio: String?
    let id: String
    
    init(name: String, email: String,  image: UIImage, bio: String, id: String) {
        self.name = name
        self.email = email
        self.image = image
        self.bio = bio
        self.id = id
    }
}

