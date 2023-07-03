import Foundation
import FirebaseAuth

protocol RegisterInteracting: AnyObject {
    func loadData(name: String, email: String, password: String)
}

final class RegisterInteractor: RegisterInteracting {
    private let presenter: RegisterPresenting
    var auth: Auth?
    
    init(presenter: RegisterPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func loadData(name: String, email: String, password: String) {
          auth?.createUser(withEmail: email, password: password, completion: { (user, erro) in
            if erro == nil {
                print("New User Registered")
                self.presenter.displayScreen()
            } else {
                print("Failed to Register New User")
            }
        })
    }
}
