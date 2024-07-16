import UIKit

class ProductListVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var appBarTitle: UILabel!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var searchTitle: String?
    var searchCategory: String?
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    var productDb: ProductProtocol = ProductImpl()
    var products: [Product] = []
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if products.isEmpty {
            getProducts()
        }
        if searchTitle != nil && !(searchTitle!.isEmpty) {
            appBarTitle.text = self.searchTitle
        }
        if searchCategory != nil && !(searchCategory!.isEmpty) {
            appBarTitle.text = self.searchCategory?.capitalized
        }
    }
    
    // MARK: - Setup
    private func setupView() {
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "product_cv_cell")
        
        //1: Lấy giá trị của chiều ngang màn hình
        let screenWidth = UIScreen.main.bounds.width - 46
        
        //2: Tạo đối tượng layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.itemSize = CGSize(width: (screenWidth) / 2, height: (screenWidth/2) + 108)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        
        //3: Xét cho thuộc tính collectionViewLayout, của Collection View
        collectionView!.collectionViewLayout = layout
        
        // Adding tap gesture recognizer to the UIView
        let backButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapBackButton))
        backButton.addGestureRecognizer(backButtonTapGesture)
        backButton.isUserInteractionEnabled = true
    }
    
    // MARK: - Data management
    private func getProducts() {
        Task {
            IndicatorViewer.show()
            let res = await productDb.getProducts(searchKey: searchTitle, category: searchCategory)
            switch res {
            case .success(let products):
                self.products = products
                collectionView.reloadData()
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Get Data Failed", message: "Can't get products now, please try again later", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    // MARK: - Action
    @objc func onTapBackButton() {
        self.pop()
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods

}

extension ProductListVC: UICollectionViewDelegate {
    
}

extension ProductListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "product_cv_cell", for: indexPath) as! ProductCollectionViewCell
        cell.configure(product: products[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailVC.create()
        productDetailVC.product = products[indexPath.row]
        productDetailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
