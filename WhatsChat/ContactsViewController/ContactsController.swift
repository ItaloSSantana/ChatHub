import UIKit

protocol ContactsDisplaying: AnyObject {
    func doSomething()
}

final class ContactsController: ViewController<ContactsInteracting,UIView> {
    
}

extension ContactsController: ContactsDisplaying {
    func doSomething() {
        //
    }
    
    
}
