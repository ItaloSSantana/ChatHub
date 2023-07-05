import UIKit
import FirebaseStorage
import FirebaseAuth

protocol SettingsInteracting: AnyObject {
    func loadData()
    func imageRequest()
    func logoutPressed()
}

final class SettingsInteractor: SettingsInteracting {
  
    private let presenter: SettingsPresenting
    var auth: Auth?
    
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
    }
    
    func loadData() {
        //
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
    
    func imageRequest() {
        //
    }
    
}
