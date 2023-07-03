import Foundation

protocol LoginInteracting: AnyObject {
    func loadData()
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresenting
    
    init(presenter: LoginPresenting) {
        self.presenter = presenter
    }
    
    func loadData() {
        //
    }
}
