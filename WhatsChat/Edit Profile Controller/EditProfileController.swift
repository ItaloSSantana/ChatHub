import UIKit

protocol EditProfileDisplaying: AnyObject {
    func doSomething()
}

final class EditProfileController: ViewController<EditProfileInteracting,UIView> {
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.profileImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your new Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your new Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var bioTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your new Bio"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var changeImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Image", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(changeImagePressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm Changes", for: .normal)
        button.titleLabel?.tintColor = .white
        button.backgroundColor = UIColor(hexaRGBA: Constants.Colors.secondColor)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        return button
    }()
        
    private var imagePicker = UIImagePickerController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func buildViewHierarchy() {
        view.addSubview(userImage)
        view.addSubview(changeImageButton)
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(bioTextField)
        view.addSubview(confirmButton)
    }
    
    override func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base06.rawValue)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(120)
        }
        
        changeImageButton.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(Space.base02.rawValue)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(120)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(changeImageButton.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base10.rawValue)
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base10.rawValue)
        }
        
        bioTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base10.rawValue)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(bioTextField.snp.bottom).offset(Space.base03.rawValue)
            $0.centerX.equalTo(bioTextField.snp.centerX)
            $0.leading.trailing.equalToSuperview().inset(Space.base20.rawValue)
        }
    }
    
    @objc private func confirmPressed() {
        guard let safeBio = bioTextField.text else {
            print("Change at least your bio")
            return
        }
        interactor.confirmPressed(name: nameTextField.text, email: emailTextField.text, bio: safeBio)
    }
    
}

extension EditProfileController: EditProfileDisplaying {
    func doSomething() {
        //
    }
}

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   @objc private func changeImagePressed() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let safeImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
        self.userImage.image = safeImage
        interactor.changeImage(image: safeImage)
        imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}
