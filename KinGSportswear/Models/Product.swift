import Foundation

class Product {
    let name: String
    let description: String
    let image: [String]
    let price: Double
    let categoryId: [String]
    let createdAt: Date
    let sold: Int
    
    init(name: String, description: String, image: [String], price: Double, categoryId: [String], createdAt: Date, sold: Int) {
        self.name = name
        self.description = description
        self.image = image
        self.price = price
        self.categoryId = categoryId
        self.createdAt = createdAt
        self.sold = sold
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.image = data["image"] as? [String] ?? []
        self.price = data["price"] as? Double ?? 0
        self.categoryId = data["category_id"] as? [String] ?? []
        self.createdAt = data["created_at"] as? Date ?? Date.now
        self.sold = data["sold"] as? Int ?? 0
    }
}
