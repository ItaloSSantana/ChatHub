import UIKit

class TextFieldView: UIView {
   private lazy var textfield: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.text = ""
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()
    
    private lazy var textView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 11
        view.layer.shadowColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        view.layer.shadowOpacity = 0.18
        view.layer.shadowRadius = 1.0
        view.layer.masksToBounds = false
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor(hexaRGBA: Constants.Colors.blackColor)?.cgColor
        return view
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        textfield.placeholder = title
        buildHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHierarchy() {
        self.backgroundColor = .clear
        addSubview(textView)
        textView.addSubview(textfield)
        setupConstraints()
    }
    
    private func setupConstraints() {
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            textView.topAnchor.constraint(equalTo: self.topAnchor, constant: Space.none.rawValue),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Space.none.rawValue),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Space.none.rawValue),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Space.none.rawValue),
            textView.heightAnchor.constraint(equalToConstant: 40),
            
            textfield.topAnchor.constraint(equalTo: textView.topAnchor, constant: Space.none.rawValue),
            textfield.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: Space.base01.rawValue),
            textfield.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -Space.base01.rawValue),
            textfield.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: Space.none.rawValue)
        ])
    }
    
    func setText(text: String){
        textfield.text = text
        print(text)
    }
    
    func setInput(input: UIView) {
        textfield.inputView = input
    }
    
    func getText() -> String{
        if let text = textfield.text {
            return text
        }
        return ""
    }
    
    func setUsableTextField() {
        textfield.isUserInteractionEnabled = true
    }
    
    func setUnusableTextField() {
        textfield.isUserInteractionEnabled = false
    }
}
