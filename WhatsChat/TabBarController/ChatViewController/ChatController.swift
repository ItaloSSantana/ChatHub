import UIKit
import Kingfisher

protocol ChatDisplaying: AnyObject {
    func sendMessage()
    func loadMessages(messages: [ChatViewModel])
    func loadContactName(name: String)
}

final class ChatController: ViewController<ChatInteracting,UIView> {
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.background)
        return image
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var addDocumentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: Constants.Images.documentIcon), for: .normal)
        button.addTarget(self, action: #selector(sendImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textfield = UITextField()
        return textfield
    }()
    
    private lazy var sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = UIImageView(image: UIImage(named: Constants.Images.background))
        tableView.register(LeftChatCell.self, forCellReuseIdentifier: LeftChatCell.identifier)
        tableView.register(RightChatCell.self, forCellReuseIdentifier: RightChatCell.identifier)
        tableView.register(RightImageCell.self, forCellReuseIdentifier: RightImageCell.identifier)
        tableView.register(LeftImageCell.self, forCellReuseIdentifier: LeftImageCell.identifier)
        tableView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    var messages: [ChatViewModel] = []
    private var imagePicker = UIImagePickerController()
    var initialBounds: CGRect?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        interactor.addListenerLoadMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        imagePicker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if initialBounds == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            view.layer.masksToBounds = true
            initialBounds = view.bounds
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.removeListener()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(messageView)
        view.addSubview(chatTableView)
        messageView.addSubview(addDocumentButton)
        messageView.addSubview(textField)
        messageView.addSubview(sendMessageButton)
    }
    
    override func setupConstraints() {
        messageView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        chatTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(messageView.snp.top).offset(Space.base00.rawValue)
        }
        
        addDocumentButton.snp.makeConstraints {
            $0.top.equalTo(messageView.snp.top).offset(Space.base01.rawValue)
            $0.leading.equalTo(messageView.snp.leading).offset(Space.base02.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(30)
        }
        
        sendMessageButton.snp.makeConstraints {
            $0.top.equalTo(messageView.snp.top).offset(Space.base01.rawValue)
            $0.trailing.equalTo(messageView.snp.trailing).offset(-Space.base02.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalTo(messageView).inset(Space.base01.rawValue)
            $0.leading.equalTo(addDocumentButton.snp.trailing).offset(Space.base01.rawValue)
            $0.trailing.equalTo(sendMessageButton.snp.leading).offset(-Space.base01.rawValue)
        }
    }
    
    @objc private func sendPressed() {
        guard let message = textField.text else {return}
        interactor.sendMessage(message: message)
    }
    
    @objc private func sendImage() {
        imagePicker.sourceType = .savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func configureViews() {
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func keyboardWillShow() {
        guard let initialBounds = initialBounds else {return}
        self.view.frame = CGRect(x: 0, y: -initialBounds.height / 2.8, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height)
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardWillHide() {
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        self.view.layoutIfNeeded()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ChatController: ChatDisplaying {
    func loadMessages(messages: [ChatViewModel]) {
        self.messages = messages
        chatTableView.reloadData()
    }
    
    func loadContactName(name: String) {
        self.title = name
    }
    
    func sendMessage() {
        textField.text = ""
    }
}

extension ChatController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rightCell = tableView.dequeueReusableCell(withIdentifier: RightChatCell.identifier, for: indexPath) as? RightChatCell else {return UITableViewCell()}
        guard let leftCell = tableView.dequeueReusableCell(withIdentifier: LeftChatCell.identifier, for: indexPath) as? LeftChatCell else {return UITableViewCell()}
        guard let rightImageCell = tableView.dequeueReusableCell(withIdentifier: RightImageCell.identifier, for: indexPath) as? RightImageCell else {return UITableViewCell()}
        guard let leftImageCell = tableView.dequeueReusableCell(withIdentifier: LeftImageCell.identifier, for: indexPath) as? LeftImageCell else {return UITableViewCell()}
        let reversedMessages: [ChatViewModel] = messages.reversed()
        let message = reversedMessages[indexPath.row]
        
        if message.isSenderCurrentUser {
            if let text = message.text {
                    rightCell.setupCell(text: text)

                return rightCell
            } else {
                if let image = message.imageUrl {
                    rightImageCell.setupCell(imageUrl: image)
                    return rightImageCell
                }
            }
        } else {
            if let text = message.text {
                leftCell.setupCell(text: text)
                return leftCell
            } else {
                if let image = message.imageUrl {
                    leftImageCell.setupCell(imageUrl: image)
                    return leftImageCell
                }
            }
        }
        
        return UITableViewCell()
    }
}

extension ChatController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let safeImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            interactor.sendImage(image: safeImage)
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
}


