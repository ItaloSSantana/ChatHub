import UIKit

protocol ContactsDelegate: AnyObject {
    func addPressed()
    func contactChat(viewModel: ContactViewModel)
}

protocol ContactsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func addPressed()
    func contactChat(sender: ContactViewModel)
}

class ContactsCoordinator: ContactsCoordinating {
    var viewController: UIViewController?
    private let delegate: ContactsDelegate
    
    init(delegate: ContactsDelegate) {
        self.delegate = delegate
    }
    
    func addPressed() {
        delegate.addPressed()
    }
    
    func contactChat(sender: ContactViewModel) {
        delegate.contactChat(viewModel: sender)
    }
    
}
