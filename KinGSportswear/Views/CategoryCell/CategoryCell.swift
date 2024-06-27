import UIKit

class CategoryCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(category: String) {
        imageView.image = UIImage(named: "category_\(category)")
        label.text = category.capitalized
    }
}
