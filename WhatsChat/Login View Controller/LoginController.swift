import UIKit
import SnapKit

protocol LoginDisplaying: AnyObject {
    func doSomething()
}

final class LoginController: ViewController<LoginInteracting, UIView> {
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.logoImage)
        image.contentMode = .scaleToFill
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
    
    private lazy var gradientImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: Constants.Images.blueHorGradient)
        return view
    }()
    
    private lazy var emailTextField = TextFieldView(title: "Enter your Email")
    
    private lazy var passwordTextField = TextFieldView(title: "Enter your Password")
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.9
        button.layer.masksToBounds = false
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.verifyLogin()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(gradientImage)
        view.addSubview(whiteView)
        whiteView.addSubview(logoImage)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
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
        
        logoImage.snp.makeConstraints {
            //$0.top.equalToSuperview().offset(Space.base27.rawValue)
            $0.width.equalTo(240)
            $0.height.equalTo(240)
            $0.centerX.equalTo(whiteView.snp.centerX)
            $0.centerY.equalTo(whiteView.snp.centerY)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.bottom).offset(Space.base08.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(280)
        }
      
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base01.rawValue)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(280)
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
            $0.bottom.equalToSuperview().offset(-Space.base15.rawValue)
        }
    }
    
    @objc private func openRegister() {
        interactor.openRegister()
    }
    
    @objc private func loginPressed() {
        interactor.validateLogin(email: emailTextField.getText(), password: passwordTextField.getText())
    }
    
    override func configureViews() {
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        self.hideKeyboardWhenTappedAround()
    }
}

extension LoginController: LoginDisplaying {
    func doSomething() {
    }
}

