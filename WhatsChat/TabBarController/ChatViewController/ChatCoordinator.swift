import UIKit

protocol ChatDelegate: AnyObject {
}

protocol ChatCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
}

class ChatCoordinator: ChatCoordinating {
    var viewController: UIViewController?
    private let delegate: ChatDelegate
    
    init(delegate: ChatDelegate) {
        self.delegate = delegate
    }
}
