import FirebaseFirestore

class UserImpl: UserProtocol {
    let db = Firestore.firestore()
    
    func getCurrentUser(email: String) async -> Result<UserModel, Error> {
        do {
            let snapshot = try await db.collection("user").whereField("email", isEqualTo: email).getDocuments();
            let data = snapshot.documents[0].data();
            print(data)
            return Result.success(UserModel(data: data))
        } catch {
            return Result.failure(Errors.noAvailableUser)
        }
    }
    
    func createUser(email: String, password: String) async -> Result<UserModel, Error> {
        do {
            let snapshot = try await db.collection("user").getDocuments();
            let data = snapshot.documents[0].data();
            print(data)
            return Result.success(UserModel(data: data))
        } catch {
            return Result.failure(error)
        }
    }
    
    func changeUserInfo(user: UserModel) async -> Result<Bool, Error> {
        do {
            let snapshot = try await db.collection("user").getDocuments();
            let data = snapshot.documents[0].data();
            print(data)
            return Result.success(true)
        } catch {
            return Result.failure(Errors.noAvailableUser)
        }
    }
}
