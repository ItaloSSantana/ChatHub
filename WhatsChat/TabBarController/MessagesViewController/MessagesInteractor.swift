import Foundation

protocol MessagesInteracting: AnyObject {
    func loadData()
}

final class MessagesInteractor: MessagesInteracting {
    private let presenter: MessagesPresenting
    
    init(presenter: MessagesPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
}
