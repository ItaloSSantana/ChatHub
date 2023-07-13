import Foundation

protocol ChatPresenting: AnyObject {
    func sendMessage()
    func loadMessages(messages: [MessageViewModel])
    func removeListener()
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
    
    func loadMessages(messages: [MessageViewModel]) {
        viewController?.loadMessages(messages: messages)
    }
    
    func removeListener() {
        viewController?.removeListener()
    }
}

