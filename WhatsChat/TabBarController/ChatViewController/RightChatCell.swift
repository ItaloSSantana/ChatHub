import UIKit

class RightChatCell: UITableViewCell {
    static let identifier = "RightChatCell"

    private lazy var cellView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        self.addSubview(cellView)
        cellView.addSubview(label)
    }
    
    private func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(self).inset(Space.none.rawValue)
            $0.leading.equalTo(self.snp.leading).offset(Space.base15.rawValue)
        }
        
        label.snp.makeConstraints {
            $0.edges.equalTo(cellView).offset(Space.base02.rawValue)
        }
    }
    
    func setupCell(text: String) {
        label.text = text
    }
    
}
