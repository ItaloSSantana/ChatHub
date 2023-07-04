import UIKit

protocol SettingsDisplaying: AnyObject {
    func doSomething()
}

final class SettingsController: ViewController<SettingsInteracting,UIView> {
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    override func buildViewHierarchy() {
        view.addSubview(logoutButton)
    }
    
    override func setupConstraints() {
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
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
