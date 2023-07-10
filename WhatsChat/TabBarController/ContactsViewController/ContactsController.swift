import UIKit

protocol ContactsDisplaying: AnyObject {
    func doSomething()
    func getContacts(contacts: [UserViewModel])
    func getContactImage(image: UIImage)
    func isLoadEnabled(verify: Bool)
}

final class ContactsController: ViewController<ContactsInteracting,UIView> {
    private lazy var searchBar: UISearchBar = {
           let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.minimal
        search.placeholder = " Search..."
        search.sizeToFit()
        search.isTranslucent = true
        search.delegate = self
        search.clipsToBounds = true
        search.layer.cornerRadius = 25
        search.backgroundImage = UIImage()
        search.barTintColor = .clear
        search.searchTextField.layer.cornerRadius = 20
        //search.searchTextField.backgroundColor = .lightGray
        search.searchTextField.layer.masksToBounds = true
           return search
       }()
    
    lazy var contactsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.register(ContactsCell.self, forCellReuseIdentifier: ContactsCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var prepareView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var prepareLoad: UILabel = {
       let label = UILabel()
        label.text = "Loading..."
        return label
    }()
    
    private var contactList: [UserViewModel] = []
    private var contactImage: UIImage?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contactList.removeAll()
        self.contactsTableView.reloadData()
        self.interactor.loadData()
        tabBarController?.navigationItem.title = "Contacts"
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addTapped))
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(contactList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    override func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(contactsTableView)
        view.addSubview(prepareView)
        prepareView.addSubview(prepareLoad)
    }
    
    override func setupConstraints() {
        prepareView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        prepareLoad.snp.makeConstraints {
            $0.centerY.equalTo(prepareView)
            $0.centerX.equalTo(prepareView)
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base00.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.base01.rawValue)
        }
        
        contactsTableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(Space.base02.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.none.rawValue)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        print("pressed")
        interactor.addPressed()
    }
    
    
    
}

extension ContactsController: ContactsDisplaying {
    func getContactImage(image: UIImage) {
        contactImage = image
    }
    
    func isLoadEnabled(verify: Bool) {
        if verify {
            print("loading...")
        } else {
           prepareView.isHidden = true
            contactsTableView.reloadData()
        }
    }
    
    func getContacts(contacts: [UserViewModel]) {
        contactList = contacts
    }
    
    func doSomething() {
        //
    }
}

extension ContactsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //
    }
}

extension ContactsController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCell.identifier, for: indexPath) as? ContactsCell {
            let contactData = contactList[indexPath.row]
            print(contactData)
            cell.setupCell(contact: contactData)
            
            return cell
        }
        return UITableViewCell()
    }
}
