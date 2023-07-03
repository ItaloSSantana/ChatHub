import Foundation

protocol RegisterPresenting: AnyObject {
    func displayScreen()
}

final class RegisterPresenter: RegisterPresenting {
    weak var viewController: RegisterController?
    private let coordinator: RegisterCoordinating
    
    init(coordinator: RegisterCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
}
