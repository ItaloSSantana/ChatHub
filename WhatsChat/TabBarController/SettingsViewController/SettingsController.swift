import UIKit

protocol SettingsDisplaying: AnyObject {
    func getUserData(data: ProfileViewModel)
}

final class SettingsController: ViewController<SettingsInteracting,UIView> {
    private lazy var cardView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        return view
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.profileImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.secondColor)?.cgColor
        return image
    }()
    
    private lazy var imageView: UIView = {
       let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.secondColor)?.cgColor
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.secondColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var userDisplayName: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var userDisplayEmail: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var userDisplayBio: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.tintColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Settings"
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        interactor.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(cardView)
        cardView.addSubview(imageView)
        imageView.addSubview(userImage)
        cardView.addSubview(verticalStack)
        verticalStack.addArrangedSubview(userDisplayName)
        verticalStack.addArrangedSubview(userDisplayEmail)
        verticalStack.addArrangedSubview(userDisplayBio)
        view.addSubview(editProfileButton)
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        cardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.none.rawValue)
            $0.leading.trailing.equalToSuperview().offset(Space.none.rawValue)
            $0.height.equalTo(225)
        }
        
        imageView.snp.makeConstraints {
            //$0.top.equalTo(cardView.snp.top).offset(Space.base12.rawValue)
            $0.centerY.equalTo(cardView.snp.centerY)
            $0.leading.equalToSuperview().offset(Space.base06.rawValue)
            $0.height.equalTo(120)
            $0.width.equalTo(120)
        }
        
        userImage.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
        verticalStack.snp.makeConstraints {
            $0.centerY.equalTo(userImage.snp.centerY)
            $0.leading.equalTo(userImage.snp.trailing).offset(Space.base05.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base03.rawValue)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(Space.base05.rawValue)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(editProfileButton.snp.bottom).offset(Space.base04.rawValue)
            $0.centerX.equalTo(editProfileButton.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(120)
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
        userImage.image = data.image
        userDisplayEmail.text = data.email
        userDisplayName.text = data.name
        userDisplayBio.text = data.bio
    }
}
