import UIKit

enum ChatFactory {
    static func make(delegate: ChatDelegate) -> UIViewController {
        let coordinator = ChatCoordinator(delegate:delegate)
        let presenter = ChatPresenter(coordinator: coordinator)
        let interactor = ChatInteractor(presenter: presenter)
        let controller = ChatController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
