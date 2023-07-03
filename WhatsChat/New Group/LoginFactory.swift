import UIKit

enum LoginFactory {
    static func make(delegate: LoginDelegate) -> UIViewController {
        let coordinator = LoginCoordinator(delegate: delegate)
        let presenter = LoginPresenter(coordinator: coordinator)
        let interactor = LoginInteractor(presenter: presenter)
        let controller = LoginController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
