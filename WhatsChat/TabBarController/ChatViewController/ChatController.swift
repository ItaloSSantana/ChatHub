import UIKit

protocol ChatDisplaying: AnyObject {
    func doSomething()
}

final class ChatController: ViewController<ChatInteracting,UIView> {
    private lazy var backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.background)
        return image
    }()
    
    private lazy var messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
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
    
    private lazy var sendMessage: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        return button
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = UIImageView(image: UIImage(named: Constants.Images.background))
        tableView.register(LeftChatCell.self, forCellReuseIdentifier: LeftChatCell.identifier)
       // tableView.register(RightChatCell.self, forCellReuseIdentifier: RightChatCell.identifier)
        return tableView
    }()
    
    let messages = ["Olaaaa","tudo bem","to bem e vc","to bem tbm","que otimo cara","perfeito","maravilha","ufa",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
        view.backgroundColor = .white
    }
    
    override func buildViewHierarchy() {
        view.addSubview(messageView)
        view.addSubview(chatTableView)
        messageView.addSubview(addDocumentButton)
        messageView.addSubview(textField)
        messageView.addSubview(sendMessage)
        
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
        
        sendMessage.snp.makeConstraints {
            $0.top.equalTo(messageView.snp.top).offset(Space.base01.rawValue)
            $0.trailing.equalTo(messageView.snp.trailing).offset(-Space.base02.rawValue)
            $0.height.equalTo(30)
            $0.width.equalTo(50)
        }
        
        textField.snp.makeConstraints {
            $0.top.bottom.equalTo(messageView).inset(Space.base01.rawValue)
            $0.leading.equalTo(addDocumentButton.snp.trailing).offset(Space.base01.rawValue)
            $0.trailing.equalTo(sendMessage.snp.leading).offset(-Space.base01.rawValue)
        }
        
    }
}

extension ChatController: ChatDisplaying {
    func doSomething() {
        //
    }
}

extension ChatController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let rightCell = tableView.dequeueReusableCell(withIdentifier: RightChatCell.identifier, for: indexPath) as! RightChatCell
        let leftCell = tableView.dequeueReusableCell(withIdentifier: LeftChatCell.identifier, for: indexPath) as! LeftChatCell
        
        let message = messages[indexPath.row]
        leftCell.setupCell(text: message)
        return leftCell
//        if indexPath.row % 2 == 0 {
//            rightCell.setupCell(text: message)
//            return rightCell
//        } else {
//            leftCell.setupCell(text: message)
//            return leftCell
//        }
//
        
    }}
