import Foundation

protocol LoginInteracting: AnyObject {
    func loadData()
    func openRegister()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
    func openRegister() {
        presenter.openRegister()
    }
}
