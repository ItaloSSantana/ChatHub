import UIKit

protocol ContactsPresenting: AnyObject {
    func displayScreen(contacts: [UserViewModel])
    func setContactImage(image: UIImage)
    func addPressed()
    func isLoadEnabled(verify: Bool)
    func contactChat(sender: UserViewModel)
}

final class ContactsPresenter: ContactsPresenting {
    weak var viewController: ContactsDisplaying?
    private let coordinator: ContactsCoordinating
    
    init(coordinator: ContactsCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(contacts: [UserViewModel]) {
        viewController?.getContacts(contacts: contacts)
    }
    func addPressed() {
        coordinator.addPressed()
    }
    
    func setContactImage(image: UIImage) {
        viewController?.getContactImage(image: image)
    }
    
    func isLoadEnabled(verify: Bool) {
        viewController?.isLoadEnabled(verify: verify)
    }
    
    func contactChat(sender: UserViewModel) {
        coordinator.contactChat(sender: sender)
    }
    
}
