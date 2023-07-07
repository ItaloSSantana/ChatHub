import UIKit

enum AddContactFactory {
    static func make(delegate: AddContactDelegate) -> UIViewController {
        let coordinator = AddContactCoordinator(delegate:delegate)
        let presenter = AddContactPresenter(coordinator: coordinator)
        let interactor = AddContactInteractor(presenter: presenter)
        let controller = AddContactController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
