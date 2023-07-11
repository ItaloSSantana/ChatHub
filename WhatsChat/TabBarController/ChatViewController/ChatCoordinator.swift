import UIKit

protocol ChatDelegate: AnyObject {
    func continueFlow()
}

protocol ChatCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

class ChatCoordinator: ChatCoordinating {
    var viewController: UIViewController?
    private let delegate: ChatDelegate
    
    init(delegate: ChatDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
}
