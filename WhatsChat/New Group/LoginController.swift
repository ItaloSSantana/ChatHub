import UIKit

protocol LoginDisplaying: AnyObject {
    func doSomething()
}

class LoginController: ViewController<LoginInteracting, UIView> {
    private lazy var logoImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "logo")
        return image
    }()
    
    
    private lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func buildViewHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    
    
}

extension LoginController: LoginDisplaying {
    func doSomething() {
        //
    }
}

