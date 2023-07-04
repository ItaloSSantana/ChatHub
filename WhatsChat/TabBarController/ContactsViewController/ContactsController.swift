import UIKit

protocol ContactsDisplaying: AnyObject {
    func doSomething()
}

final class ContactsController: ViewController<ContactsInteracting,UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension ContactsController: ContactsDisplaying {
    func doSomething() {
        //
    }
}
