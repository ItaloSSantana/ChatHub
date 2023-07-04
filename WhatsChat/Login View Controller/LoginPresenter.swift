import Foundation

protocol LoginPresenting: AnyObject {
    func confirmLogin()
    func openRegister()
    func confirmAutoLogin()
}

final class LoginPresenter: LoginPresenting {
    weak var viewController: LoginDisplaying?
    private var coordinator: LoginCoordinating
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
    
    func confirmLogin() {
        coordinator.confirmLogin()
    }
    
    func openRegister() {
        coordinator.openRegister()
    }
    
    func confirmAutoLogin() {
        coordinator.confirmAutoLogin()
    }
}
