import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

protocol SettingsInteracting: AnyObject {
    func loadData()
    func editPressed()
    func logoutPressed()
}

final class SettingsInteractor: SettingsInteracting {
    private let presenter: SettingsPresenting
    var auth: Auth?
    private var firestore: Firestore?
    private var storage: Storage?
    private var userID: String = ""
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
        storage = Storage.storage()
        if let id = auth?.currentUser?.uid {
            self.userID = id
        }
    }
    
    func loadData(){
        let userRef = firestore?.collection("users").document(userID)
        userRef?.getDocument(completion: { (snapshot, error) in
                guard let safeData = snapshot?.data(),
                      let safeName = safeData["name"] as? String,
                      let safeBio = safeData["bio"] as? String,
                      let safeEmail = safeData["email"] as? String,
                      let imageUrl = safeData["imageUrl"] as? String,
                      let storageRef = self.storage?.reference(forURL: imageUrl) else {return}
                storageRef.getData(maxSize: 2 * 1024 * 1024) { (data, error) -> Void in
                    guard let safeData = data else {return}
                        if let image = UIImage(data: safeData) {
                            let viewModel = ProfileViewModel(name: safeName, email: safeEmail, image: image, bio: safeBio)
                            self.presenter.displayScreen(data: viewModel)
                }
            }
        })
    }
        
        func logoutPressed() {
            do {
                try auth?.signOut()
                presenter.logoutPressed()
            } catch {
                print("Error logging out user")
            }
        }
    
    func editPressed() {
        presenter.editPressed()
    }
}



