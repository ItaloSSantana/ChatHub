import Foundation

protocol SettingsPresenting: AnyObject {
    func displayScreen(data: ProfileViewModel)
    func logoutPressed()
    func editPressed()
}

final class SettingsPresenter: SettingsPresenting {
    weak var viewController: SettingsDisplaying?
    private let coordinator: SettingsCoordinating
    
    init(coordinator: SettingsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(data: ProfileViewModel) {
        viewController?.getUserData(data: data)
    }
    
    func logoutPressed() {
        coordinator.logoutPressed()
    }
    
    func editPressed() {
        coordinator.editPressed()
    }
}
