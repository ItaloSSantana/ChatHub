import UIKit

protocol AddContactDelegate: AnyObject {
    func continueFlow()
    func addContactPressed()
}

protocol AddContactCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
    func addContactPressed()
}

class AddContactCoordinator: AddContactCoordinating {
    var viewController: UIViewController?
    private let delegate: AddContactDelegate
    
    init(delegate: AddContactDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
    func addContactPressed() {
        delegate.addContactPressed()
    }
    
}
