import UIKit

public protocol ViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func configureStyles()
    func buildLayout()
}

public extension ViewConfiguration {
    func buildLayout() {
        buildViewHierarchy()
        setupConstraints()
        configureViews()
        configureStyles()
    }
    
    func configureViews() { }
    
    func configureStyles() { }
}

open class ViewController<Interactor, V: UIView>: UIViewController, ViewConfiguration {
    public let interactor: Interactor
    public var rootView = V()
    
    @available(iOS, deprecated: 13, message: "ViewModel was renamed to Interactor. Use self.interactor instead")
    public var viewModel: Interactor {
        interactor
    }
    
    @available(iOS, deprecated: 13, message: "init(viewModel: ViewModel) was renamed to Interactor. Use init(interactor:) instead")
    public init(viewModel: Interactor) {
        self.interactor = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    override open func loadView() {
        view = rootView
    }
    
    open func buildViewHierarchy() { }
    
    open func setupConstraints() { }
    
    @available(iOS, deprecated: 13, message: "configureStyles was deprecated. Use Lazy block vars instead")
    open func configureStyles() { }
    
    open func configureViews() { }
}

public extension ViewController where Interactor == Void {
    convenience init(_ interactor: Interactor = ()) {
        self.init(interactor: interactor)
    }
}
