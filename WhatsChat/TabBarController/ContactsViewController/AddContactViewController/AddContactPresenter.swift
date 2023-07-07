import Foundation

protocol AddContactPresenting: AnyObject {
    func displayScreen()
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
}
