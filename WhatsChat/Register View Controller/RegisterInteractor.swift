import Foundation

protocol RegisterInteracting: AnyObject {
    func loadData()
}

final class RegisterInteractor: RegisterInteracting {
    private let presenter: RegisterPresenting
    
    init(presenter: RegisterPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
}
