import UIKit

protocol LoginDelegate: AnyObject {
    func continueFlow()
}

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func continueFlow()
}

final class LoginCoordinator: LoginCoordinating {
    var viewController: UIViewController?
    private var delegate: LoginDelegate
   
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
}
