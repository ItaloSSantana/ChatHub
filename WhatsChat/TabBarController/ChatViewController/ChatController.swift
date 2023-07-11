import UIKit

protocol ChatDisplaying: AnyObject {
    func doSomething()
}

final class ChatController: ViewController<ChatInteracting,UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension ChatController: ChatDisplaying {
    func doSomething() {
        //
    }
}
