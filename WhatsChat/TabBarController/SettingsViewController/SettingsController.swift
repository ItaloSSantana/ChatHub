import UIKit

protocol SettingsDisplaying: AnyObject {
    func getUserData(data: ProfileViewModel)
}

final class SettingsController: ViewController<SettingsInteracting,UIView> {
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 8.0
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var gradientImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Constants.Images.blueBackgroundSettings)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 80
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
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
        image.layer.cornerRadius = 75
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        return image
    }()
    
    private lazy var imageView: UIView = {
       let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 75
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
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
        label.textAlignment = .center
        label.font = UIFont(name: Constants.Fonts.hindVadodaraFont, size: 26)
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 3)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 3
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var userDisplayEmail: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 3)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 3
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var userDisplayBio: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        label.layer.shadowOffset = CGSize(width: 2, height: 3)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 3
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.9
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(editProfilePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.tintColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 0.9
        button.layer.masksToBounds = false
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
      
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Settings"
        navigationController?.isNavigationBarHidden = true
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
        view.addSubview(gradientImage)
        gradientImage.addSubview(imageView)
        imageView.addSubview(userImage)
        gradientImage.addSubview(verticalStack)
        verticalStack.addArrangedSubview(userDisplayName)
        verticalStack.addArrangedSubview(userDisplayEmail)
        verticalStack.addArrangedSubview(userDisplayBio)
        view.addSubview(editProfileButton)
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        cardView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(Space.none.rawValue)
            $0.leading.trailing.equalToSuperview().offset(Space.none.rawValue)
            $0.height.equalTo(400)
        }
        
        gradientImage.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(Space.none.rawValue)
            $0.leading.trailing.equalToSuperview().offset(Space.none.rawValue)
            $0.height.equalTo(400)
        }
            
        imageView.snp.makeConstraints {
            $0.top.equalTo(gradientImage.snp.top).offset(Space.base18.rawValue)
            $0.centerX.equalTo(gradientImage.snp.centerX)
            $0.height.equalTo(150)
            $0.width.equalTo(150)
        }
        
        userImage.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
        verticalStack.snp.makeConstraints {
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.top.equalTo(imageView.snp.bottom).offset(Space.base02.rawValue)
        }
        
        editProfileButton.snp.makeConstraints {
            $0.top.equalTo(gradientImage.snp.bottom).offset(Space.base05.rawValue)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(30)
            $0.width.equalTo(320)
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
