import UIKit

protocol AddContactDisplaying: AnyObject {
    func doSomething()
}

final class AddContactController: ViewController<AddContactInteracting,UIView> {
    private lazy var backgroundGradient: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Images.blueHorGradient)
        return imageView
    }()
    
    private lazy var addLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter new contact email to add new contact"
        label.textAlignment = .center
        return label
    }()

    private lazy var emailTextField = TextFieldView(title: "Enter your new contact email")

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Contact", for: .normal)
        button.titleLabel?.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)?.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 3.0
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(addContactPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height / 3.5 * 2, width: self.view.bounds.width, height: UIScreen.main.bounds.height / 5 * 3)
        self.view.layer.cornerRadius = 20
        self.view.layer.masksToBounds = true
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundGradient)
        view.addSubview(addLabel)
        view.addSubview(emailTextField)
        view.addSubview(confirmButton)
    }
    
    override func setupConstraints() {
        backgroundGradient.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base08.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base04.rawValue)
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
            $0.leading.trailing.equalToSuperview().inset(Space.base20.rawValue)
        }
    }
    
    @objc private func addContactPressed() {
        interactor.addContactPressed(email: emailTextField.getText())
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
           dismiss(animated: true, completion: nil)
       }
}

extension AddContactController: AddContactDisplaying {
    func doSomething() {
        //
    }
}
