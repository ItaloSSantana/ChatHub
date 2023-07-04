import Foundation

protocol ContactsPresenting: AnyObject {
    func displayScreen()
}

final class ContactsPresenter: ContactsPresenting {
    weak var viewController: ContactsDisplaying?
    private let coordinator: ContactsCoordinating
    
    init(coordinator: ContactsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
}
