class MessagesViewModel {
    let userID: String
    let contactID: String
    let contactName: String
    let contactPhotoUrl: String
    let lastMessage: String
    
    init(userID: String, contactID: String,  contactName: String, contactPhotoUrl: String, lastMessage: String) {
        self.userID = userID
        self.contactID = contactID
        self.contactName = contactName
        self.contactPhotoUrl = contactPhotoUrl
        self.lastMessage = lastMessage
    }
}
