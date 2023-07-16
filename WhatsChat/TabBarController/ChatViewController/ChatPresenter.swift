import Foundation

protocol ChatPresenting: AnyObject {
    func sendMessage()
    func loadMessages(messages: [ChatViewModel])
}

final class ChatPresenter: ChatPresenting {
    weak var viewController: ChatDisplaying?
    private let coordinator: ChatCoordinating
    
    init(coordinator: ChatCoordinating) {
        self.coordinator = coordinator
    }
    
    func sendMessage() {
        viewController?.sendMessage()
    }
    
    func loadMessages(messages: [ChatViewModel]) {
        viewController?.loadMessages(messages: messages)
    }
}

