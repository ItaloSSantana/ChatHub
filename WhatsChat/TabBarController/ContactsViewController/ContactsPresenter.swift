import UIKit

protocol ContactsPresenting: AnyObject {
    func displayScreen(contacts: [Dictionary<String, Any>])
    func setContactImage(image: UIImage)
    func addPressed()
}

final class ContactsPresenter: ContactsPresenting {
    weak var viewController: ContactsDisplaying?
    private let coordinator: ContactsCoordinating
    
    init(coordinator: ContactsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(contacts: [Dictionary<String, Any>]) {
        viewController?.getContacts(contacts: contacts)
    }
    func addPressed() {
        coordinator.addPressed()
    }
    
    func setContactImage(image: UIImage) {
        viewController?.getContactImage(image: image)
    }
    
}
