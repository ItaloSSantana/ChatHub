import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AddContactInteracting: AnyObject {
    func addContactPressed(email: String?)
}

final class AddContactInteractor: AddContactInteracting {
    private let presenter: AddContactPresenting
    
    private var currentUserID: String = ""
    private var currentUserEmail: String = ""
    
    private var auth: Auth?
    private var firestore: Firestore?
    
    init(presenter: AddContactPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        if let currentID = auth?.currentUser?.uid, let currentEmail = auth?.currentUser?.email {
            self.currentUserID = currentID
            self.currentUserEmail = currentEmail
        }
        
    }
    
    func addContactPressed(email: String?) {
        guard let safeEmail = email, safeEmail != currentUserEmail else {
            print("Not a valid email")
            return
        }
        
        firestore?.collection("users")
            .whereField("email", isEqualTo: safeEmail)
            .getDocuments{ (resultSnapshot, error) in
                guard let totalItens = resultSnapshot?.count else {
                    print("error getting count")
                    return
                }
                if totalItens != 0 {
                    guard let snapshot = resultSnapshot else {
                        print("error get snapshot")
                        return
                    }
                    snapshot.documents.forEach { (document) in
                        let data = document.data()
                        self.saveContact(contactData: data)
                    }
                } else {
                    print("There's no user with this email")
                }
            }
    }
    
    private func saveContact(contactData: Dictionary<String, Any>) {
        guard let safeContactID = contactData["id"] else {return}
        firestore?.collection("users")
            .document(currentUserID)
            .collection("contacts")
            .document(String(describing: safeContactID))
            .setData(contactData, completion: { (error) in
                guard error == nil else {
                    print("Error saving contact data")
                    return
                }
                self.presenter.addContactPressed()
            })
    }
    
}
