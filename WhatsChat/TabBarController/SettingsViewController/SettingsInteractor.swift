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
    private var userID: String = ""
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
        if let id = auth?.currentUser?.uid {
            self.userID = id
        }
    }
    
    func loadData(){
        let userRef = firestore?.collection("users").document(userID)
        
        userRef?.getDocument(completion: { (snapshot, error) in
            guard let safeData = snapshot?.data() else {return}
            let safeName = safeData["name"] as? String
            let safeEmail = safeData["email"] as? String
            let viewModel = ProfileViewModel(name: safeName, email: safeEmail)
            self.presenter.displayScreen(data: viewModel)
            
        })
    }
    
    func logoutPressed() {
        do {
            try auth?.signOut()
            print("LogoutSuccess")
            presenter.logoutPressed()
        } catch {
            print("Error logging out user")
        }
    }
    
    func editPressed() {
        presenter.editPressed()
    }
}


struct ProfileViewModel {
    let name: String?
    let email: String?
}
