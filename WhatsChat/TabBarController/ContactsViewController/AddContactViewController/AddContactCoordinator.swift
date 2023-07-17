import UIKit

protocol AddContactDelegate: AnyObject {
    func addContactPressed()
}

protocol AddContactCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func addContactPressed()
}

class AddContactCoordinator: AddContactCoordinating {
    var viewController: UIViewController?
    private let delegate: AddContactDelegate
    
    init(delegate: AddContactDelegate) {
        self.delegate = delegate
    }
    
    func addContactPressed() {
        delegate.addContactPressed()
    }
    
}
