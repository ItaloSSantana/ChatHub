import UIKit

enum ContactsFactory {
    static func make(delegate: ContactsDelegate) -> UIViewController {
        let coordinator = ContactsCoordinator(delegate:delegate)
        let presenter = ContactsPresenter(coordinator: coordinator)
        let interactor = ContactsInteractor(presenter: presenter)
        let controller = ContactsController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
