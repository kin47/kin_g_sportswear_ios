import Foundation
import FirebaseAuth

enum Errors: Error {
    case noAvailableUser
}

protocol FirebaseAuthenticationProtocol {
    func signInWithEmailAndPassword(email: String, password: String) async -> Result<User, Error>;
    func signUpWithEmailAndPassword(email: String, password: String) async -> Result<User, Error>;
    func signOut() -> Result<Bool, Error>;
    func getUserInfo() -> Result<User, Error>;
}

class FirebaseAuthenticationImpl: FirebaseAuthenticationProtocol {
    func signInWithEmailAndPassword(email: String, password: String) async -> Result<User, Error> {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = authResult.user
            return Result.success(user)
        } catch {
            print(error)
            return Result.failure(error)
        }
    }
    
    func signUpWithEmailAndPassword(email: String, password: String) async -> Result<User, Error> {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authResult.user
            return Result.success(user)
        } catch {
            print(error)
            return Result.failure(error)
        }
    }
    
    func signOut() -> Result<Bool, Error> {
        do {
            try Auth.auth().signOut()
            return Result.success(true)
        } catch {
            print(error)
            return Result.failure(error)
        }
    }
    
    func getUserInfo() -> Result<User, Error> {
        let user = Auth.auth().currentUser
        if let user {
            return Result.success(user)
        } else {
            return Result.failure(Errors.noAvailableUser)
        }
    }
}
