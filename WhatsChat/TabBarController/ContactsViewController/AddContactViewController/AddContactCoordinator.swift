import UIKit

protocol AddContactDelegate: AnyObject {
    func continueFlow()
}

protocol AddContactCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
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
}
