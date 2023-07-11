import Foundation

protocol ChatPresenting: AnyObject {
    func displayScreen()
}

final class ChatPresenter: ChatPresenting {
    weak var viewController: ChatDisplaying?
    private let coordinator: ChatCoordinating
    
    init(coordinator: ChatCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen() {
        //
    }
}
