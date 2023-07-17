class ContactViewModel {
    let name: String
    let email: String?
    let image: String
    let bio: String?
    let id: String
    
    init(name: String, email: String?,  image: String, bio: String?, id: String) {
        self.name = name
        self.email = email
        self.image = image
        self.bio = bio
        self.id = id
    }
}
