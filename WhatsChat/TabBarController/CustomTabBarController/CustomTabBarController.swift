import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let messagesController = MessagesFactory.make(delegate: self)
        messagesController.title = "Messages"
        
        let contactsController = ContactsFactory.make(delegate: self)
        contactsController.title = "Contacts"
        
        let settingsController = SettingsFactory.make(delegate: self)
        settingsController.title = "Settings"
        
        let tabBarAppearence = UITabBarAppearance()
        tabBarAppearence.backgroundColor = .white
        tabBarAppearence.configureWithTransparentBackground()
        tabBarItem.standardAppearance = tabBarAppearence
        self.setViewControllers([messagesController,contactsController,settingsController], animated: true)
        self.tabBar.tintColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        
        setupItems()
    }
    
    func setupItems() {
          guard var items = self.tabBar.items else {return}
        let images = [Constants.Images.messages,Constants.Images.contacts, Constants.Images.settings]

          for x in 0...2 {
              items[x].image = UIImage(named: images[x])?.withRenderingMode(.alwaysOriginal)
          }
      }
}

extension CustomTabBarController: ContactsDelegate {
    func continueFlow() {
        //
    }
}

extension CustomTabBarController: SettingsDelegate {
    func editPressed() {
        let editController = EditProfileFactory.make(delegate: self)
        navigationController?.pushViewController(editController, animated: true)
    }
    
    func logoutPressed() {
        print("at tab bar")
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension CustomTabBarController: MessagesDelegate {
    
}

extension CustomTabBarController: EditProfileDelegate {
    func confirmPressed() {
        print("exit edit controller")
        navigationController?.popViewController(animated: true)
    }
}
