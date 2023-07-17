class ChatViewModel {
    let userID: String?
    let text: String?
    let imageUrl: String?
    let isSenderCurrentUser: Bool
    
    init(userID: String, text: String?, imageUrl: String?, isSenderCurrentUser: Bool) {
        self.userID = userID
        self.text = text
        self.imageUrl = imageUrl
        self.isSenderCurrentUser = isSenderCurrentUser
    }
}
