import Foundation

protocol EditProfilePresenting: AnyObject {
    func confirmPressed()
}

final class EditProfilePresenter: EditProfilePresenting {
    weak var viewController: EditProfileDisplaying?
    private let coordinator: EditProfileCoordinating
    
    init(coordinator: EditProfileCoordinating) {
        self.coordinator = coordinator
    }

    func confirmPressed() {
        coordinator.confirmPressed()
    }
}
