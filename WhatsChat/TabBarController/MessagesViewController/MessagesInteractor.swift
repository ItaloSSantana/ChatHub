import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

protocol MessagesInteracting: AnyObject {
    func loadData()
}

final class MessagesInteractor: MessagesInteracting {
    private let presenter: MessagesPresenting
    
    private var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var currentUserID = ""
    
    init(presenter: MessagesPresenting) {
        self.presenter = presenter
        storage = Storage.storage()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        
        if let currentID = auth?.currentUser?.uid {
            self.currentUserID = currentID
        }
    }
    
    func loadData() {
        //
    }
}
