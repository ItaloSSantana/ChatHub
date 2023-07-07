import UIKit

protocol ContactsDisplaying: AnyObject {
    func doSomething()
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
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Contacts"
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "test", style: .done, target: self, action: #selector(addTapped))
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addTapped))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        view.backgroundColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
    }
    
    override func buildViewHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(contactsTableView)
    }
    
    
    
    override func setupConstraints() {
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactsCell.identifier, for: indexPath) as? ContactsCell {
                   return cell
               }
               return UITableViewCell()
    }
    
    
}
