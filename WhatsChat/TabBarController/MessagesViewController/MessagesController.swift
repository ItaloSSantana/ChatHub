import UIKit

protocol MessagesDisplaying: AnyObject {
    func doSomething()
}

final class MessagesController: ViewController<MessagesInteracting,UIView> {
    private lazy var messagesTableView: UITableView = {
       let tableView = UITableView()
        tableView.rowHeight = 80
        tableView.register(MessagesCell.self, forCellReuseIdentifier: MessagesCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.navigationItem.title = "Messages"
        navigationController?.isNavigationBarHidden = false
        navigationItem.setHidesBackButton(true, animated: true)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        view.backgroundColor = .blue
    }
    
    override func buildViewHierarchy() {
        view.addSubview(messagesTableView)
    }
    
    override func setupConstraints() {
        messagesTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
}

extension MessagesController: MessagesDisplaying {
    func doSomething() {
        //
    }
}

extension MessagesController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessagesCell.identifier, for: indexPath) as? MessagesCell else {return UITableViewCell()}
        return cell
    }
    
    
}
