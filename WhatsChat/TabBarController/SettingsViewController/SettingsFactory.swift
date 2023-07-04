import UIKit

enum SettingsFactory {
    static func make(delegate: SettingsDelegate) -> UIViewController {
        let coordinator = SettingsCoordinator(delegate:delegate)
        let presenter = SettingsPresenter(coordinator: coordinator)
        let interactor = SettingsInteractor(presenter: presenter)
        let controller = SettingsController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
