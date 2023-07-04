import Foundation

protocol SettingsPresenting: AnyObject {
    func displayScreen()
    func logoutPressed()
}

final class SettingsPresenter: SettingsPresenting {
    weak var viewController: SettingsDisplaying?
    private let coordinator: SettingsCoordinating
    
    init(coordinator: SettingsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
    
    func logoutPressed() {
        coordinator.logoutPressed()
    }
}
