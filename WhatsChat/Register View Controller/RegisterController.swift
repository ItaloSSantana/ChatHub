import UIKit

protocol RegisterDisplaying: AnyObject {
    func doSomething()
}

final class RegisterController: ViewController<RegisterInteracting, UIView> {
    private lazy var userImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "usuario")
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var rePasswordTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Confirm your password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
    }
    
    override func buildViewHierarchy() {
        view.addSubview(userImage)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(registerButton)
    }
    
    override func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base26.rawValue)
            $0.width.equalTo(240)
            $0.height.equalTo(180)
            $0.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base01.rawValue)
            $0.width.equalTo(240)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Space.base01.rawValue)
            $0.width.equalTo(240)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base01.rawValue)
            $0.width.equalTo(240)
            $0.centerX.equalToSuperview()
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Space.base01.rawValue)
            $0.width.equalTo(240)
            $0.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(rePasswordTextField.snp.bottom).offset(Space.base02.rawValue)
            $0.trailing.leading.equalToSuperview().inset(Space.base22.rawValue)
            $0.height.equalTo(30)
        }
    }
    
    @objc private func signUpPressed() {
        interactor.signUpPressed(name: nameTextField.text,
                                 email: emailTextField.text,
                                 password: passwordTextField.text,
                                 rePassword: rePasswordTextField.text)
    }
}

extension RegisterController: RegisterDisplaying {
    func doSomething() {
        print("Success")
    }
}
