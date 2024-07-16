import UIKit

class HomeVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var greetingsLabel: UILabel!
    @IBOutlet weak var categoryHCV: UICollectionView!
    @IBOutlet weak var newCollectionHCV: UICollectionView!
    @IBOutlet weak var bestSellerHCV: UICollectionView!
    @IBOutlet weak var seeAllNewCollection: UIButton!
    @IBOutlet weak var seeAllBestSeller: UIButton!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    var productDb: ProductProtocol = ProductImpl()
    var userDb: UserProtocol = UserImpl()
    var newCollection: [Product] = []
    var bestSeller: [Product] = []
    var categories: [String] = ["clothes", "ball", "shoes", "others"]
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserInfo()
        getNewCollections()
        getBestSeller()
    }
    
    // MARK: - Setup
    private func setupView() {
        let nib = UINib(nibName: "CategoryCell", bundle: .main)
        categoryHCV.register(nib, forCellWithReuseIdentifier: "category_cv_cell")
        categoryHCV.delegate = self
        categoryHCV.dataSource = self
        
        let screenWidth = UIScreen.main.bounds.width - 32
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenWidth - 32) / 4, height: (screenWidth - 32) / 4 + 32)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        categoryHCV.showsHorizontalScrollIndicator = false
        categoryHCV.collectionViewLayout = layout
        
        let nib2 = UINib(nibName: "ProductCollectionViewCell", bundle: .main)
        newCollectionHCV.register(nib2, forCellWithReuseIdentifier: "new_collection_cv_cell")
        newCollectionHCV.delegate = self
        newCollectionHCV.dataSource = self
        
        let nib3 = UINib(nibName: "ProductCollectionViewCell", bundle: .main)
        bestSellerHCV.register(nib3, forCellWithReuseIdentifier: "best_seller_cv_cell")
        bestSellerHCV.delegate = self
        bestSellerHCV.dataSource = self
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: 150, height: 258)
        layout2.minimumInteritemSpacing = 16
        layout2.scrollDirection = .horizontal
        newCollectionHCV.showsHorizontalScrollIndicator = false
        bestSellerHCV.showsHorizontalScrollIndicator = false
        newCollectionHCV!.collectionViewLayout = layout2
        bestSellerHCV!.collectionViewLayout = layout2
        
        NSLayoutConstraint.activate([
            categoryHCV.heightAnchor.constraint(equalToConstant: (screenWidth - 32) / 4 + 32),
            bestSellerHCV.heightAnchor.constraint(equalToConstant: 265),
            newCollectionHCV.heightAnchor.constraint(equalToConstant: 265)
        ])
    }
    
    // MARK: - Data management
    private func getUserInfo() {
        Task {
            IndicatorViewer.show()
            let firebaseUserRes = firebaseAuth.getUserInfo()
            switch firebaseUserRes {
            case .success(let firebaseUser):
                let result = await userDb.getCurrentUser(email: firebaseUser.email ?? "")
                switch result {
                case .success(let user):
                    print("Home VC \(user.username)")
                    greetingsLabel.text = "Hi \(user.username)!"
                case .failure(_):
                    // create the alert
                    let alert = UIAlertController(title: "Fetch Data Failed", message: "Can't get current user", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Fetch Data Failed", message: "Can't get current user", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    private func getNewCollections() {
        Task {
            IndicatorViewer.show()
            let res = await productDb.getNewCollection()
            switch res {
            case .success(let products):
                self.newCollection = products
                newCollectionHCV.reloadData()
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Get Data Failed", message: "Can't get new collection now, please try again later", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    private func getBestSeller() {
        Task {
            IndicatorViewer.show()
            let res = await productDb.getBestSeller()
            switch res {
            case .success(let products):
                self.bestSeller = products
                bestSellerHCV.reloadData()
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Get Data Failed", message: "Can't get new collection now, please try again later", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    // MARK: - Action
    @IBAction func goToNewCollections(_ sender: UIButton) {
        let productListVC = ProductListVC.create()
        productListVC.hidesBottomBarWhenPushed = true
        productListVC.searchTitle = "New Collection"
        productListVC.products = newCollection
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
    @IBAction func goToBestSeller(_ sender: Any) {
        let productListVC = ProductListVC.create()
        productListVC.hidesBottomBarWhenPushed = true
        productListVC.searchTitle = "Best Seller"
        productListVC.products = bestSeller
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods
    
}

extension HomeVC: UICollectionViewDelegate {
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.categoryHCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category_cv_cell", for: indexPath) as! CategoryCell
            cell.configure(category: categories[indexPath.row])
            return cell
        case self.newCollectionHCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "new_collection_cv_cell", for: indexPath) as! ProductCollectionViewCell
            if !newCollection.isEmpty {
                cell.configure(product: newCollection[indexPath.row])
            }
            return cell
        case self.bestSellerHCV:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "best_seller_cv_cell", for: indexPath) as! ProductCollectionViewCell
            if !bestSeller.isEmpty {
                cell.configure(product: bestSeller[indexPath.row])
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "best_seller_cv_cell", for: indexPath) as! ProductCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case self.categoryHCV:
            let productListVC = ProductListVC.create()
            productListVC.hidesBottomBarWhenPushed = true
            productListVC.searchCategory = categories[indexPath.row]
            navigationController?.pushViewController(productListVC, animated: true)
            break
        case self.newCollectionHCV:
            let productDetailVC = ProductDetailVC.create()
            productDetailVC.hidesBottomBarWhenPushed = true
            productDetailVC.product = newCollection[indexPath.row]
            navigationController?.pushViewController(productDetailVC, animated: true)
            break
        case self.bestSellerHCV:
            let productDetailVC = ProductDetailVC.create()
            productDetailVC.hidesBottomBarWhenPushed = true
            productDetailVC.product = bestSeller[indexPath.row]
            navigationController?.pushViewController(productDetailVC, animated: true)
            break
        default:
            break
        }
    }
}
