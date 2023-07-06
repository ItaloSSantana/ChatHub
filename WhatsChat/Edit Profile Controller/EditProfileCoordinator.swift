import UIKit

protocol EditProfileDelegate: AnyObject {
    func confirmPressed()
}

protocol EditProfileCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func confirmPressed()
}

class EditProfileCoordinator: EditProfileCoordinating {
    var viewController: UIViewController?
    private let delegate: EditProfileDelegate
    
    init(delegate: EditProfileDelegate) {
        self.delegate = delegate
    }
    
    
    func confirmPressed() {
        delegate.confirmPressed()
    }
}
