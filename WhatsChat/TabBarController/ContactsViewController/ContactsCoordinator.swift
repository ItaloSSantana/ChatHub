import UIKit

protocol ContactsDelegate: AnyObject {
    func continueFlow()
}

protocol ContactsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
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
}
