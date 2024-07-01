import FirebaseFirestore

class ProductImpl: ProductProtocol {
    let db = Firestore.firestore()
    
    func getProducts(searchKey: String?, category: String?) async -> Result<[Product], any Error> {
        do {
            let query = db.collection("product")
            var snapshot: QuerySnapshot?
            if let category {
                snapshot = try await query.whereField("category_id", arrayContains: category).getDocuments()
            } else {
                snapshot = try await query.getDocuments()
            }
            let data = snapshot!.documents;
            var products: [Product] = []
            for item in data {
                if searchKey != nil && !searchKey!.isEmpty {
                    let name: String = item.data()["name"] as! String
                    if name.contains(searchKey!) {
                        print(item.data())
                        products.append(Product(data: item.data()))
                    }
                } else {
                    print(item.data())
                    products.append(Product(data: item.data()))
                }
            }
            return Result.success(products)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
    
    func getNewCollection() async -> Result<[Product], any Error> {
        do {
            let snapshot = try await db.collection("product").order(by: "created_at", descending: true).limit(to: 10).getDocuments()
            let data = snapshot.documents;
            var products: [Product] = []
            for item in data {
                print(item.data())
                products.append(Product(data: item.data()))
            }
            return Result.success(products)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
    
    func getBestSeller() async -> Result<[Product], any Error> {
        do {
            let snapshot = try await db.collection("product").order(by: "sold", descending: true).limit(to: 10).getDocuments()
            let data = snapshot.documents;
            var products: [Product] = []
            for item in data {
                print(item.data())
                products.append(Product(data: item.data()))
            }
            return Result.success(products)
        } catch {
            return Result.failure(Errors.getCartError)
        }
    }
}
