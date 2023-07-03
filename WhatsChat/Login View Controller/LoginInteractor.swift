import Foundation
import FirebaseAuth

protocol LoginInteracting: AnyObject {
    func loadData(email: String, password: String)
    func openRegister()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    var auth: Auth?
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func loadData(email: String, password: String) {
        auth?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("Logged Succefully")
                self.presenter.displayScreen()
            } else {
                print(error)
            }
        })
    }
    
    func openRegister() {
        presenter.openRegister()
    }
}
