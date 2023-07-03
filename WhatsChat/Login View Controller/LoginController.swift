import UIKit
import SnapKit

protocol LoginDisplaying: AnyObject {
    func doSomething()
}

final class LoginController: ViewController<LoginInteracting, UIView> {
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not registered yet? Sign Up", for: .normal)
        button.titleLabel?.tintColor = .white
        button.addTarget(self, action: #selector(openRegister), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
    }
    
    override func setupConstraints() {
        logoImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base27.rawValue)
            $0.width.equalTo(240)
            $0.height.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom).offset(Space.base02.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base02.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Space.base08.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base22.rawValue)
            $0.height.equalTo(30)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Space.base01.rawValue)
            $0.width.equalTo(190)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func openRegister() {
        interactor.openRegister()
    }
    
    @objc private func loginPressed() {
        interactor.loadData(email: emailTextField.text, password: passwordTextField.text)
    }
    
    override func configureViews() {
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        self.hideKeyboardWhenTappedAround()
    }
}

extension LoginController: LoginDisplaying {
    func doSomething() {
        print("Logged In")
    }
}

