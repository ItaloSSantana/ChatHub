import UIKit

protocol SettingsDelegate: AnyObject {
    func continueFlow()
    func logoutPressed()
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
    func logoutPressed()
}

class SettingsCoordinator: SettingsCoordinating {
    var viewController: UIViewController?
    private let delegate: SettingsDelegate
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        //
    }
    
    func logoutPressed() {
        delegate.logoutPressed()
    }
    
}
