import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Setup
    func configure(product: Product) {
        productImage.loadImage(url: URL(string: product.image[0]))
        productName.text = product.name
        productPrice.text = product.price.removeZerosFromEnd()
    }
}
