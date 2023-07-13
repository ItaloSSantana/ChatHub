import UIKit

protocol ChatDisplaying: AnyObject {
    func sendMessage()
    func loadMessages(messages: [MessageViewModel])
    func removeListener()
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
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        return tableView
    }()
    
    var messages: [MessageViewModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.addListenerLoadMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        view.backgroundColor = .white
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
}

extension ChatController: ChatDisplaying {
    func loadMessages(messages: [MessageViewModel]) {
        self.messages = messages
        chatTableView.reloadData()
    }
    
    func sendMessage() {
        textField.text = ""
    }
    
    func removeListener() {
        print("exit")
    }
}

extension ChatController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rightCell = tableView.dequeueReusableCell(withIdentifier: RightChatCell.identifier, for: indexPath) as? RightChatCell else {return UITableViewCell()}
        guard let leftCell = tableView.dequeueReusableCell(withIdentifier: LeftChatCell.identifier, for: indexPath) as? LeftChatCell else {return UITableViewCell()}
        
        let message = messages[indexPath.row]
        guard let text = message.text else {return UITableViewCell()}
            if message.isSenderCurrentUser {
                rightCell.setupCell(text: text)
                return rightCell
            } else {
                leftCell.setupCell(text: text)
                return leftCell
            }
        }
    }
