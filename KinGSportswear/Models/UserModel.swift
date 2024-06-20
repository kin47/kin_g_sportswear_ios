class UserModel {
    let id: String
    let username: String
    let phoneNumber: String?
    let email: String
    let password: String
    let isAdmin: Bool
    let avatar: String?
    let address: String?
    let coins: Double
    
    init(id: String, username: String, phoneNumber: String, email: String, password: String, isAdmin: Bool, avatar: String, address: String, coins: Double) {
        self.id = id
        self.username = username
        self.phoneNumber = phoneNumber
        self.email = email
        self.password = password
        self.isAdmin = isAdmin
        self.avatar = avatar
        self.address = address
        self.coins = coins
    }
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.phoneNumber = data["phone_number"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.password = data["password"] as? String ?? ""
        self.isAdmin = data["is_admin"] as? Bool ?? false
        self.avatar = data["avatar"] as? String
        self.address = data["address"] as? String ?? ""
        self.coins = data["coins"] as? Double ?? 0
    }
}
