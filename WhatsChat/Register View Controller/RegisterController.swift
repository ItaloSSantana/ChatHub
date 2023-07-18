import UIKit

protocol RegisterDisplaying: AnyObject {
    func doSomething()
}

final class RegisterController: ViewController<RegisterInteracting, UIView> {
    private lazy var userImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Constants.Images.logoImage)
        image.contentMode = .scaleToFill
        return image
    }()

    private lazy var gradientImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Constants.Images.blueGradient)
        return image
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Please, Enter your name, email, and password to Register your account"
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField = TextFieldView(title: "Enter your name")

    private lazy var emailTextField = TextFieldView(title: "Enter your email")
    
    private lazy var passwordTextField = TextFieldView(title: "Enter your password")

    private lazy var rePasswordTextField = TextFieldView(title: "Confirm your password")
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.9
        button.layer.masksToBounds = false
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func buildViewHierarchy() {
        view.addSubview(gradientImage)
        view.addSubview(whiteView)
        whiteView.addSubview(userImage)
        whiteView.addSubview(label)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(rePasswordTextField)
        view.addSubview(registerButton)
    }
    
    override func setupConstraints() {
        gradientImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        whiteView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Space.none.rawValue)
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.top).offset(Space.base10.rawValue)
            $0.width.equalTo(180)
            $0.height.equalTo(180)
            $0.centerX.equalTo(whiteView.snp.centerX)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base02.rawValue)
            $0.leading.trailing.equalTo(whiteView).inset(Space.base10.rawValue)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.bottom).offset(Space.base10.rawValue)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Space.base05.rawValue)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base05.rawValue)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        
        rePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(Space.base05.rawValue)
            $0.width.equalTo(280)
            $0.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(rePasswordTextField.snp.bottom).offset(Space.base07.rawValue)
            $0.trailing.leading.equalToSuperview().inset(Space.base22.rawValue)
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-Space.base30.rawValue)
        }
    }
    
    @objc private func signUpPressed() {
        interactor.signUpPressed(name: nameTextField.getText(),
                                 email: emailTextField.getText(),
                                 password: passwordTextField.getText(),
                                 rePassword: rePasswordTextField.getText())
    }
    
    override func configureViews() {
        self.hideKeyboardWhenTappedAround()
        passwordTextField.setSafeTextEntry()
        rePasswordTextField.setSafeTextEntry()
    }
    
}

extension RegisterController: RegisterDisplaying {
    func doSomething() {
        //
    }
}
