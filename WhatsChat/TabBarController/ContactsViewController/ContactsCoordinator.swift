import UIKit

protocol ContactsDelegate: AnyObject {
    func continueFlow()
    func addPressed()
    func contactChat(sender: UserViewModel)
}

protocol ContactsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
    func addPressed()
    func contactChat(sender: UserViewModel)
}

class ContactsCoordinator: ContactsCoordinating {
    var viewController: UIViewController?
    private let delegate: ContactsDelegate
    
    init(delegate: ContactsDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
    func addPressed() {
        delegate.addPressed()
    }
    
    func contactChat(sender: UserViewModel) {
        delegate.contactChat(sender: sender)
    }
    
}
