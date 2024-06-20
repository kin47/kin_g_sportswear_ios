protocol CartProtocol {
    func addToCart(item: Cart) async -> Result<Bool, Error>
    func getCart(userEmail: String) async -> Result<[Cart], Error>
    func updateCart(cart: Cart) async -> Result<Bool, Error>
    func deleteItemInCart(cartId: String) async -> Result<Bool, Error>
    func checkout(cartItems: [Cart], user: UserModel, total: Double) async -> Result<Bool, Error>
}
