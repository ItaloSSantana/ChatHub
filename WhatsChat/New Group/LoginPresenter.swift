import Foundation

protocol LoginPresenting: AnyObject {
    func displayScreen()
}


final class LoginPresenter: LoginPresenting {
    weak var viewController: LoginDisplaying?
    private var coordinator: LoginCoordinating
    
    init(coordinator: LoginCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
}
