import Foundation

protocol AddContactPresenting: AnyObject {
    func displayScreen()
    func addContactPressed()
}

final class AddContactPresenter: AddContactPresenting {
    weak var viewController: AddContactDisplaying?
    private let coordinator: AddContactCoordinating
    
    init(coordinator: AddContactCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
    func addContactPressed() {
        coordinator.addContactPressed()
    }
}
