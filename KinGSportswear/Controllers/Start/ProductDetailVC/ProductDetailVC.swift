import UIKit

class ProductDetailVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var appBarTitle: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Variables
    var product: Product?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product {
            appBarTitle.text = product.name
            productNameLabel.text = product.name
            productCategoryLabel.text = product.categoryId[0]
            priceLabel.text = product.price.removeZerosFromEnd()
            descriptionLabel.text = product.description
        }
    }
    
    // MARK: - Action
    @IBAction func onTapBackButton(_ sender: UIButton) {
        self.pop()
    }
}
