import UIKit

enum RegisterFactory {
    static func make(delegate: RegisterDelegate) -> UIViewController {
        let coordinator = RegisterCoordinator(delegate: delegate)
        let presenter = RegisterPresenter(coordinator: coordinator)
        let interactor = RegisterInteractor(presenter: presenter)
        let controller = RegisterController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
