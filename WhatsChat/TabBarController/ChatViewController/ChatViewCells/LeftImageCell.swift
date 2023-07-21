import UIKit
import Kingfisher

class LeftImageCell: UITableViewCell {
    static let identifier = "LeftImageCell"

    private lazy var cellView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(hexaRGBA: Constants.Colors.lightPurple)
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.lightPurple)?.cgColor
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowOpacity = 1.0
        view.layer.shadowRadius = 3.0
        view.layer.masksToBounds = false
        return view
    }()
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        return image
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
        cellView.addSubview(cellImage)
        setupConstraints()
    }
    
    private func setupConstraints() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Space.base04.rawValue)
            $0.bottom.equalToSuperview().offset(-Space.base04.rawValue)
            $0.leading.equalToSuperview().offset(Space.base02.rawValue)
            $0.trailing.equalTo(self.snp.trailing).offset(-Space.base15.rawValue)
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
