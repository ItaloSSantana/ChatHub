import UIKit

enum MessagesFactory {
    static func make(delegate: MessagesDelegate) -> UIViewController {
        let coordinator = MessagesCoordinator(delegate:delegate)
        let presenter = MessagesPresenter(coordinator: coordinator)
        let interactor = MessagesInteractor(presenter: presenter)
        let controller = MessagesController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
