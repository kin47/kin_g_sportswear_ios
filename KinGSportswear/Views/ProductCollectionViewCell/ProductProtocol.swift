protocol ProductProtocol {
    func getProducts(searchKey: String?, category: String?) async -> Result<[Product], Error>
    func getNewCollection() async -> Result<[Product], Error>
    func getBestSeller() async -> Result<[Product], Error>
}
