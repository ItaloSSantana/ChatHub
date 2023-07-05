import UIKit

protocol SettingsDisplaying: AnyObject {
    func doSomething()
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
        label.text = "name lastname"
        return label
    }()
    
    private lazy var userDisplayEmail: UILabel = {
        let label = UILabel()
        label.text = "email@email.com"
        return label
    }()
    
    private lazy var changeImage: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Image", for: .normal)
        button.titleLabel?.tintColor = .systemBlue
        button.addTarget(self, action: #selector(changeImagePressed), for: .touchUpInside)
        return button
    }()
  
    private var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = .white
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
}

extension SettingsController: SettingsDisplaying {
    func doSomething() {
        //
    }
}

extension SettingsController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc private func changeImagePressed() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let safeImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.userImage.image = safeImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
