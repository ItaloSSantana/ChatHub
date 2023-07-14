import UIKit
import Kingfisher

class RightImageCell: UITableViewCell {
    static let identifier = "RightImageCell"

    private lazy var cellView: UIView = {
    let view = UIView()
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.defaultColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        return image
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
        cellView.addSubview(cellImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base02.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base02.rawValue)
            $0.leading.equalToSuperview().offset(Space.base15.rawValue)
            $0.trailing.equalTo(self.snp.trailing).offset(-Space.base02.rawValue)
            $0.height.equalTo(200)
        }
        
        cellImage.snp.makeConstraints {
            $0.edges.equalTo(cellView).inset(Space.base02.rawValue)
            $0.height.greaterThanOrEqualTo(Space.base04.rawValue)
        }
    }
    
    func setupCell(imageUrl: String) {
        cellImage.kf.setImage(with: URL(string: imageUrl))
    }
}
