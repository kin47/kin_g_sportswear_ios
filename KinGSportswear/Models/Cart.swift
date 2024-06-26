import Foundation

class Cart: Product {
    let cartItemId: String
    var quantity: Int
    let size: String
    let userEmail: String
    
    init(cartItemId: String, quantity: Int, size: String, userEmail: String, name: String, description: String, image: [String], price: Double, categoryId: [String], createdAt: Date, sold: Int) {
        self.cartItemId = cartItemId
        self.quantity = quantity
        self.size = size
        self.userEmail = userEmail
        super.init(name: name, description: description, image: image, price: price, categoryId: categoryId, createdAt: createdAt, sold: sold)
    }
    
    init(data: [String: Any], id: String) {
        self.cartItemId = data["cartItemId"] as? String ?? id
        self.size = data["size"] as? String ?? ""
        self.userEmail = data["userEmail"] as? String ?? ""
        self.quantity = data["quantity"] as? Int ?? 0
        super.init(data: data)
    }
    
    func toData() -> [String: Any] {
        let data: [String: Any] = [
            "cartItemId": cartItemId,
            "size": size,
            "userEmail": userEmail,
            "quantity": quantity,
            "name": name,
            "description": description,
            "image": image,
            "price": price,
            "category_id": categoryId,
            "created_at": createdAt,
            "sold": sold,
        ]
        return data
    }
}
