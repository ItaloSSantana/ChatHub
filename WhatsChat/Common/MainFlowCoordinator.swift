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
    func openRegister() {
        let registerController = RegisterFactory.make(delegate: self)
        navigationController.present(registerController, animated: true, completion: nil)
    }
    
    func loginFlow() {
        let tabController = CustomTabBarController()
        navigationController.pushViewController(tabController, animated: true)
    }
    
    func confirmAutoLogin() {
        let tabController = CustomTabBarController()
        navigationController.pushViewController(tabController, animated: true)
    }
}

extension MainFlowCoordinator: RegisterDelegate {
    func continueFlow() {
        let tabController = CustomTabBarController()
        navigationController.pushViewController(tabController, animated: true)
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
