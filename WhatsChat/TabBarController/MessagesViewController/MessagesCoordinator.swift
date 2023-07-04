import UIKit

protocol MessagesDelegate: AnyObject {
    func continueFlow()
}

protocol MessagesCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

class MessagesCoordinator: MessagesCoordinating {
    var viewController: UIViewController?
    private let delegate: MessagesDelegate
    
    init(delegate: MessagesDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
}
