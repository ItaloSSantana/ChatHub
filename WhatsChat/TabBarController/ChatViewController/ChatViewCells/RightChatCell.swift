import UIKit

class RightChatCell: UITableViewCell {
    static let identifier = "RightChatCell"
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.lightBlue)
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.lightBlue)?.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 3.0
        view.layer.masksToBounds = false
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        self.addSubview(cellView)
        cellView.addSubview(label)
        setupConstraints()
    }
    
    private func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base04.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base04.rawValue)
            $0.leading.equalToSuperview().offset(Space.base15.rawValue)
            $0.trailing.equalTo(self.snp.trailing).offset(-Space.base02.rawValue)
        }
        label.snp.makeConstraints {
            $0.edges.equalTo(cellView.snp.edges).inset(Space.base02.rawValue)
            $0.height.greaterThanOrEqualTo(Space.base04.rawValue)
        }
    }
    
    func setupCell(text: String) {
        label.text = text
    }
}

