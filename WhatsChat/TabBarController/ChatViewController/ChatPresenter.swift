import Foundation

protocol ChatPresenting: AnyObject {
    func sendMessage()
    func loadMessages(messages: [ChatViewModel])
    func loadContactName(name: String)
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
    
    func loadContactName(name: String) {
        viewController?.loadContactName(name: name)
    }
}

