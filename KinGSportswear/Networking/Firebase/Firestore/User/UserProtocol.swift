protocol UserProtocol {
    func getCurrentUser(email: String) async -> Result<UserModel, Error>
    func createUser(email: String, password: String) async -> Result<UserModel, Error>
    func changeUserInfo(user: UserModel) async -> Result<Bool, Error>
}
