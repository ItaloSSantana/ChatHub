import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

protocol ContactsInteracting: AnyObject {
    func loadData()
    func addPressed()
    func loadContactImage(image: String?)
}

final class ContactsInteractor: ContactsInteracting {
    private let presenter: ContactsPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var currentUserID = ""
    private var contactList: [Dictionary<String, Any>] = []
    
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
        firestore?.collection("users")
            .document(currentUserID)
            .collection("contacts")
            .getDocuments(completion: { (resultSnapshot, error) in
                guard let snapshot = resultSnapshot else {
                    print("cannot get user")
                    return}
                snapshot.documents.forEach { (document) in
                    let contactData = document.data()
                    self.contactList.append(contactData)
                    self.presenter.displayScreen(contacts: self.contactList)
                }
            })
    }
    
    func loadContactImage(image: String?) {
        guard let imageUrl = image,
              let storageRef = self.storage?.reference(forURL: imageUrl) else {return}
        storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) -> Void in
            guard let safeData = data else {return}
            if let image = UIImage(data: safeData) {
                print(image)
                self.presenter.setContactImage(image: image)
            }
        }
    }
    
    func addPressed() {
        presenter.addPressed()
    }
    
}
