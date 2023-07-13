import UIKit

enum ChatFactory {
    static func make(delegate: ChatDelegate,
                     viewModel: UserViewModel) -> UIViewController {
        let coordinator = ChatCoordinator(delegate:delegate)
        let presenter = ChatPresenter(coordinator: coordinator)
        let interactor = ChatInteractor(presenter: presenter, viewModel: viewModel)
        let controller = ChatController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
