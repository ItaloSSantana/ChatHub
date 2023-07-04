import Foundation

protocol MessagesPresenting: AnyObject {
    func displayScreen()
}

final class MessagesPresenter: MessagesPresenting {
    weak var viewController: MessagesDisplaying?
    private let coordinator: MessagesCoordinating
    
    init(coordinator: MessagesCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
}
