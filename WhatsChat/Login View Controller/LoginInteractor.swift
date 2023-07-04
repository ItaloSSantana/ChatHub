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
            if error == nil {
                print("Logged Succefully")
                self.presenter.confirmLogin()
            } else {
                print("Not logged")
            }
        })
    }
    
    func verifyLogin() {
        auth?.addStateDidChangeListener({ (authentication, user) in
            if user != nil {
                print("user already logged in")
                self.presenter.confirmAutoLogin()
            } else {
                print("Enter email and password first")
            }
        })
    }
    
    func openRegister() {
        presenter.openRegister()
    }
}
