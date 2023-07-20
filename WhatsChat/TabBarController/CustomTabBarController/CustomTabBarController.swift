import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let messagesController = MessagesFactory.make(delegate: self)
        messagesController.tabBarController?.navigationItem.title = "Messages"
        
        let contactsController = ContactsFactory.make(delegate: self)
        contactsController.tabBarController?.navigationItem.title = "Contacts"
        
        let settingsController = SettingsFactory.make(delegate: self)
        settingsController.tabBarController?.navigationItem.title = "Settings"
        
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
            items[x].image = UIImage(named: images[x])?.withRenderingMode(.automatic)
          }
      }
}

extension CustomTabBarController: ContactsDelegate {
    func contactChat(viewModel: ContactViewModel) {
        let chatController = ChatFactory.make(delegate: self, viewModel: viewModel)
        navigationController?.pushViewController(chatController, animated: true)
    }
    
    func addPressed(){
        let editController = AddContactFactory.make(delegate: self)
        navigationController?.present(editController, animated: true)
    }
}

extension CustomTabBarController: SettingsDelegate {
    func editPressed() {
        let editController = EditProfileFactory.make(delegate: self)
        navigationController?.present(editController, animated: true)
    }
    
    func logoutPressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension CustomTabBarController: MessagesDelegate {
    func contactInfo(contactData: ContactViewModel) {
        let chatController = ChatFactory.make(delegate: self, viewModel: contactData)
        navigationController?.pushViewController(chatController, animated: true)
    }
}

extension CustomTabBarController: EditProfileDelegate {
    func confirmPressed() {
        navigationController?.dismiss(animated: true)
    }
}

extension CustomTabBarController: AddContactDelegate {
    func addContactPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension CustomTabBarController: ChatDelegate {
    
}
