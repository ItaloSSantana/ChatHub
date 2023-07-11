import Foundation

protocol ChatInteracting: AnyObject {
    func loadData()
}

final class ChatInteractor: ChatInteracting {
    private let presenter: ChatPresenting
    
    init(presenter: ChatPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
}
