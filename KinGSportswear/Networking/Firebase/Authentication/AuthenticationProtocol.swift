import FirebaseAuth

protocol FirebaseAuthenticationProtocol {
    func signInWithEmailAndPassword(email: String, password: String) async -> Result<User, Error>;
    func signUpWithEmailAndPassword(email: String, password: String) async -> Result<User, Error>;
    func signOut() -> Result<Bool, Error>;
    func getUserInfo() -> Result<User, Error>;
}
