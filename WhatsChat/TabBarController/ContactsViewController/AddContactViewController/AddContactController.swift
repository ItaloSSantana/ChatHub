import UIKit

protocol AddContactDisplaying: AnyObject {
    func doSomething()
}

final class AddContactController: ViewController<AddContactInteracting,UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension AddContactController: AddContactDisplaying {
    func doSomething() {
        //
    }
}
