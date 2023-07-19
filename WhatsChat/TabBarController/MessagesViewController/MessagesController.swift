import UIKit

protocol MessagesDisplaying: AnyObject {
    func loadLastMessages(messages: [MessagesViewModel])
    func loadCurrentUserData(userData: ContactViewModel)
}

final class MessagesController: ViewController<MessagesInteracting,UIView> {
    private lazy var backgroundImage: UIImageView = {
    let image = UIImageView()
        image.image = UIImage(named: Constants.Images.blueGradient)
        return image
    }()
   
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.profileImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 4
        return image
    }()
    
    private lazy var imageView: UIView = {
       let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 4
        view.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.whiteColor)?.cgColor
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 3)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var currentUserName: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.hindBold, size: 26)
        label.textColor = .white
        label.text = "Current Name"
        return label
    }()
    
    private lazy var currentUserBio: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: Constants.Fonts.hindVadodaraFont, size: 18)
        label.textColor = .white
        label.text = "Current Bio"
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = -6
        return stack
    }()
    
    private lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4.0
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var messagesTableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.backgroundColor = .white
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 40
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        tableView.layer.shadowOffset = CGSize(width: 0.0, height: -4.0)
        tableView.layer.shadowOpacity = 0.5
        tableView.layer.shadowRadius = 4.0
        tableView.register(MessagesCell.self, forCellReuseIdentifier: MessagesCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var messagesList: [MessagesViewModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        interactor.loadLastMessage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        view.backgroundColor = .blue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.removeListener()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(imageView)
        imageView.addSubview(userImage)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(currentUserName)
        verticalStack.addArrangedSubview(currentUserBio)
        view.addSubview(whiteView)
        whiteView.addSubview(messagesTableView)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base30.rawValue)
            $0.leading.equalToSuperview().offset(Space.base06.rawValue)
            $0.height.equalTo(60)
            $0.width.equalTo(60)
        }
        
        userImage.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
        
        verticalStack.snp.makeConstraints {
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.leading.equalTo(imageView.snp.trailing).offset(Space.base04.rawValue)
        }
     
        whiteView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(Space.base10.rawValue)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        messagesTableView.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.top).offset(Space.base06.rawValue)
            $0.leading.trailing.bottom.equalTo(whiteView)
        }
    }
}

extension MessagesController: MessagesDisplaying {
    func loadLastMessages(messages: [MessagesViewModel]) {
        messagesList = messages
        messagesTableView.reloadData()
    }
    
    func loadCurrentUserData(userData: ContactViewModel) {
        currentUserName.text = userData.name
        userImage.kf.setImage(with: URL(string: userData.image))
        currentUserBio.text = userData.bio
    }
}

extension MessagesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesCell.identifier, for: indexPath) as? MessagesCell else {return UITableViewCell()}
        let contact = messagesList[indexPath.row]
        cell.setupCell(contact: contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.messagesTableView.deselectRow(at: indexPath, animated: true)
        let contact = messagesList[indexPath.row]
        let newViewModel = ContactViewModel(name: contact.contactName, email: nil, image: contact.contactPhotoUrl, bio: nil, id: contact.contactID)
        interactor.contactChat(contactData: newViewModel)
    }
}
