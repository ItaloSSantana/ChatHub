import UIKit

class LeftChatCell: UITableViewCell {
    static let identifier = "LeftChatCell"

    private lazy var cellView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.thirdColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
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
            $0.top.equalToSuperview().offset(Space.base01.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base01.rawValue)
            $0.leading.equalToSuperview().offset(Space.base01.rawValue)
            $0.trailing.equalTo(self.snp.trailing).offset(-Space.base15.rawValue)
        }
        
        label.snp.makeConstraints {
            $0.edges.equalTo(cellView).inset(Space.base02.rawValue)
            $0.height.greaterThanOrEqualTo(Space.base04.rawValue)
        }
    }
    
    func setupCell(text: String) {
        label.text = text
    }
    
}
