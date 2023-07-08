import UIKit

class ContactsCell: UITableViewCell {
    static let identifier = "ContactsCell"
    
    private lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.profileImage)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        image.layer.borderWidth = 4
        image.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.secondColor)?.cgColor
        return image
    }()
    
    private lazy var userDisplayName: UILabel = {
        let label = UILabel()
        label.text = "Italo Santana"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var userDisplayEmail: UILabel = {
        let label = UILabel()
        label.text = "1@2.com"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var userDisplayBio: UILabel = {
        let label = UILabel()
        label.text = "Online"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        self.addSubview(userImage)
        self.addSubview(verticalStack)
        verticalStack.addArrangedSubview(userDisplayName)
        verticalStack.addArrangedSubview(userDisplayBio)
        verticalStack.addArrangedSubview(userDisplayEmail)
         setupConstraints()
     }
    
    private func setupConstraints() {
        userImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Space.base06.rawValue)
            $0.width.height.equalTo(50)
        }
        
        verticalStack.snp.makeConstraints {
            $0.centerY.equalTo(userImage.snp.centerY)
            $0.leading.equalTo(userImage.snp.trailing).offset(Space.base05.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base03.rawValue)
        }
    }
    
    func setupCell(contact: Dictionary<String, Any>) {
        userDisplayName.text = contact["name"] as? String
        userDisplayEmail.text = contact["email"] as? String
        userDisplayBio.text = contact["bio"] as? String
    }
    
    func setupImage(image: UIImage){
        userImage.image = image
    } 
}
