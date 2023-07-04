import UIKit

protocol LoginDelegate: AnyObject {
    func loginFlow()
    func openRegister()
    func confirmAutoLogin()
}

protocol LoginCoordinating: AnyObject {
    var viewController: UIViewController? { get set }
    func confirmLogin()
    func openRegister()
    func confirmAutoLogin()
}

final class LoginCoordinator: LoginCoordinating {
    var viewController: UIViewController?
    private var delegate: LoginDelegate
   
    init(delegate: LoginDelegate) {
        self.delegate = delegate
    }
    
    func confirmLogin() {
        delegate.loginFlow()
    }
    
    func openRegister() {
        delegate.openRegister()
    }
    
    func confirmAutoLogin() {
        delegate.confirmAutoLogin()
    }
    
}
