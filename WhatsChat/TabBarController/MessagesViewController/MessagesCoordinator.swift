import UIKit

protocol MessagesDelegate: AnyObject {
    func contactInfo(contactData: ContactViewModel)
}

protocol MessagesCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func contactChat(contactData: ContactViewModel)
}

class MessagesCoordinator: MessagesCoordinating {
    var viewController: UIViewController?
    private let delegate: MessagesDelegate
    
    init(delegate: MessagesDelegate) {
        self.delegate = delegate
    }
    
    func contactChat(contactData: ContactViewModel) {
        delegate.contactInfo(contactData: contactData)
    }
}
