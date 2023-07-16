import Foundation

protocol MessagesPresenting: AnyObject {
    func loadLastMessage(messages: [MessagesViewModel])
}

final class MessagesPresenter: MessagesPresenting {
    weak var viewController: MessagesDisplaying?
    private let coordinator: MessagesCoordinating
    
    init(coordinator: MessagesCoordinating) {
        self.coordinator = coordinator
    }
    
    func loadLastMessage(messages: [MessagesViewModel]) {
        viewController?.loadLastMessages(messages: messages)
    }
}
