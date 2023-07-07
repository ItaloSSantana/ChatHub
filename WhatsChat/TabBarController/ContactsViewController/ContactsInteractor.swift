import Foundation

protocol ContactsInteracting: AnyObject {
    func loadData()
    func addPressed()
}

final class ContactsInteractor: ContactsInteracting {
    private let presenter: ContactsPresenting
    
    init(presenter: ContactsPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
    
    func addPressed() {
        presenter.addPressed()
    }
    
}
