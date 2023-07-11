import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegisterInteracting: AnyObject {
    func signUpPressed(name: String?, email: String?, password: String?, rePassword: String?)
}

final class RegisterInteractor: RegisterInteracting {
    private let presenter: RegisterPresenting
    var auth: Auth?
    var firestore: Firestore?
    
    init(presenter: RegisterPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        firestore = Firestore.firestore()
    }
    
    func signUpPressed(name: String?, email: String?, password: String?, rePassword: String?) {
        guard let safeName = name, let safeEmail = email, let safePassword = password, safePassword == rePassword else {
            print("Error creating user")
            return
        }
        auth?.createUser(withEmail: safeEmail, password: safePassword, completion: { (resultData, erro) in
            // Save user data to firebase
            
            guard let userID = resultData?.user.uid else {return}
            self.firestore?.collection("users")
                .document(userID)
                .setData(["name" : safeName, "email": safeEmail, "id": userID, "bio": "", "imageUrl": "gs://whatschat-bd803.appspot.com/images/profile/imagem-perfil.png"] )
            
            self.presenter.displayScreen()
        })
    }
}

