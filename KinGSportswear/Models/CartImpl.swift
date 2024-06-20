import Foundation
import FirebaseFirestore

class CartImpl: CartProtocol {
    let db = Firestore.firestore()
    
    func addToCart(item: Cart) async -> Result<Bool, Error> {
        return Result.success(true)
    }
    
    func getCart(userEmail: String) async -> Result<[Cart], Error> {
        do {
            let snapshot = try await db.collection("cart").whereField("userEmail", isEqualTo: userEmail).getDocuments();
            let data = snapshot.documents;
            var cartItems: [Cart] = []
            for cartItem in data {
                print(cartItem.data())
                print(cartItem.documentID)
                cartItems.append(Cart(data: cartItem.data(), id: cartItem.documentID))
            }
            return Result.success(cartItems)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
    
    func updateCart(cart: Cart) async -> Result<Bool, Error> {
        do {
            try await db.collection("cart").document(cart.cartItemId).setData(cart.toData())
            return Result.success(true)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
    
    func deleteItemInCart(cartId: String) async -> Result<Bool, Error> {
        do {
            try await db.collection("cart").document(cartId).delete()
            return Result.success(true)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
    
    func checkout(cartItems: [Cart], user: UserModel, total: Double) async -> Result<Bool, Error> {
        return Result.success(true)
    }
}
