import Foundation

protocol ContactsInteracting: AnyObject {
    func loadData()
}

final class ContactsInteractor: ContactsInteracting {
    private let presenter: ContactsPresenting
    
    init(presenter: ContactsPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
    
}
