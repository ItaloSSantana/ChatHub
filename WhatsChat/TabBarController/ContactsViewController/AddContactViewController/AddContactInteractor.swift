import Foundation

protocol AddContactInteracting: AnyObject {
    func loadData()
}

final class AddContactInteractor: AddContactInteracting {
    private let presenter: AddContactPresenting
    
    init(presenter: AddContactPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
}
