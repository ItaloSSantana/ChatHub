import Foundation
import FirebaseAuth

protocol LoginInteracting: AnyObject {
    func validateLogin(email: String?, password: String?)
    func openRegister()
    func verifyLogin()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    var auth: Auth?
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func validateLogin(email: String?, password: String?) {
        guard let safeEmail = email, let safePassword = password else {
            //apresenta erro (presenter.showError)
            return
        }
        auth?.signIn(withEmail: safeEmail, password: safePassword, completion: { (user, error) in
            if let user = user {
                print("Logged Succefully")
                self.presenter.confirmLogin()
            } else {
                print("Not logged")
            }
        })
    }
    
    func verifyLogin() {
        if let user = auth?.currentUser {
            self.presenter.confirmAutoLogin()
        }
    }
    
    func openRegister() {
        presenter.openRegister()
    }
}
