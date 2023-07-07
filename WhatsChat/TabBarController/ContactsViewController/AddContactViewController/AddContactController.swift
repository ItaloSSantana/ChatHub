import UIKit

protocol AddContactDisplaying: AnyObject {
    func doSomething()
}

final class AddContactController: ViewController<AddContactInteracting,UIView> {
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter new contact email to add new contact"
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your new contact email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textAlignment = .center
        label.textColor = .red
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Contact", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(addContactPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func buildViewHierarchy() {
        view.addSubview(addLabel)
        view.addSubview(emailTextField)
        view.addSubview(confirmButton)
        view.addSubview(errorLabel)
    }
    
    override func setupConstraints() {
        addLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base04.rawValue)
            $0.leading.trailing.equalToSuperview().offset(Space.base04.rawValue)
            $0.height.equalTo(20)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(addLabel.snp.bottom).offset(Space.base00.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base04.rawValue)
            $0.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base02.rawValue)
            $0.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(confirmButton.snp.bottom).offset(Space.base02.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base04.rawValue)
        }
    }
    
    @objc private func addContactPressed() {
        interactor.addContactPressed(email: emailTextField.text)
    }
    
}

extension AddContactController: AddContactDisplaying {
    func doSomething() {
        //
    }
}
