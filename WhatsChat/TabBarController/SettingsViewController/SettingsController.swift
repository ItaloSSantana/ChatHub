import UIKit

protocol SettingsDisplaying: AnyObject {
    func getUserData(data: ProfileViewModel)
}

final class SettingsController: ViewController<SettingsInteracting,UIView> {
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.tintColor = .red
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.profileImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private lazy var userDisplayName: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    
    private lazy var userDisplayEmail: UILabel = {
        let label = UILabel()
        label.text = "--"
        return label
    }()
    
    private lazy var changeImage: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.tintColor = .systemBlue
        button.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        return button
    }()
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func buildViewHierarchy() {
        view.addSubview(userImage)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(userDisplayName)
        verticalStack.addArrangedSubview(userDisplayEmail)
        view.addSubview(changeImage)
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base03.rawValue)
            $0.leading.equalToSuperview().offset(Space.base03.rawValue)
            $0.height.equalTo(120)
            $0.width.equalTo(120)
        }
        
        verticalStack.snp.makeConstraints {
           // $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base03.rawValue)
            $0.centerY.equalTo(userImage.snp.centerY)
            $0.leading.equalTo(userImage.snp.trailing).offset(Space.base03.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base03.rawValue)
            
        }
        
        changeImage.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base01.rawValue)
            $0.centerX.equalTo(userImage.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
        
        logoutButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-Space.base06.rawValue)
            $0.centerY.equalTo(changeImage.snp.centerY)
        }
    }
    
    @objc private func logoutPressed() {
        interactor.logoutPressed()
    }
    
    @objc private func editProfilePressed() {
        interactor.editPressed()
    }
    
    override func configureViews() {
        view.backgroundColor = .white
    }
}

extension SettingsController: SettingsDisplaying {
    func getUserData(data: ProfileViewModel) {
        userDisplayEmail.text = data.email
        userDisplayName.text = data.name
    }
}
