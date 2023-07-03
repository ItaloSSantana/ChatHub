import UIKit

class MainFlowCoordinator {
  
    let navigationController = UINavigationController()
    var rootViewController: UIViewController {
        return navigationController
    }
    
    func start() {
        let controller = LoginFactory.make(delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
}

extension MainFlowCoordinator: LoginDelegate {
    func continueFlow() {
        //
    }
}
