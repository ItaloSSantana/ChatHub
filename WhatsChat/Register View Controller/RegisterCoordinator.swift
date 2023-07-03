import UIKit

protocol RegisterDelegate: AnyObject {
    func continueFlow()
}

protocol RegisterCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class RegisterCoordinator: RegisterCoordinating {
    var viewController: UIViewController?
    private var delegate: RegisterDelegate
    
    init(delegate: RegisterDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
    
    
}
