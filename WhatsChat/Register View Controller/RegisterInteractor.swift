import Foundation
import FirebaseAuth

protocol RegisterInteracting: AnyObject {
    func signUpPressed(name: String?, email: String?, password: String?, rePassword: String?)
}

final class RegisterInteractor: RegisterInteracting {
    private let presenter: RegisterPresenting
    var auth: Auth?
    
    init(presenter: RegisterPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func signUpPressed(name: String?, email: String?, password: String?, rePassword: String?) {
        guard let safeName = name, let safeEmail = email, let safePassword = password else {return}
        if safePassword == rePassword {
            auth?.createUser(withEmail: safeEmail, password: safePassword, completion: { (user, erro) in
                if erro == nil {
                    print("New User Registered")
                    self.presenter.displayScreen()
                } else {
                    print("Failed to Register New User")
                }
            })
        }
    }
}
