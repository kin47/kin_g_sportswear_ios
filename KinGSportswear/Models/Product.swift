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
}
