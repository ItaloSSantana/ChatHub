import UIKit

protocol SettingsDelegate: AnyObject {
    func editPressed()
    func logoutPressed()
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func editPressed()
    func logoutPressed()
}

class SettingsCoordinator: SettingsCoordinating {
    var viewController: UIViewController?
    private let delegate: SettingsDelegate
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
    
    func editPressed() {
        delegate.editPressed()
    }
    
    func logoutPressed() {
        delegate.logoutPressed()
    }
    
}
