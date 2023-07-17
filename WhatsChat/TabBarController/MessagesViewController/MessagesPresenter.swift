import Foundation

protocol MessagesPresenting: AnyObject {
    func loadLastMessage(messages: [MessagesViewModel])
    func contactChat(contactData: ContactViewModel)
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
    
    func contactChat(contactData: ContactViewModel) {
        coordinator.contactChat(contactData: contactData)
    }
    
}
