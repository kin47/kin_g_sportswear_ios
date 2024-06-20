import UIKit

protocol CartTableViewCellDelegate: AnyObject {
    func didTapIncrease(for cartItem: Cart)
    func didTapDecrease(for cartItem: Cart)
    func didTapDelete(for cartItem: Cart)
}

class CartTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var cartItemImage: UIImageView!
    @IBOutlet weak var cartItemProductName: UILabel!
    @IBOutlet weak var cartItemSize: UILabel!
    @IBOutlet weak var cartItemProductPrize: UILabel!
    @IBOutlet weak var cartItemQuantity: UILabel!
    
    @IBOutlet weak var decreaseIcon: UIImageView!
    @IBOutlet weak var increaseIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    // MARK: - Variables
    private var cartItem: Cart?
    private weak var delegate: CartTableViewCellDelegate?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Setup
    func configure(cartItem: Cart, delegate: CartTableViewCellDelegate) {
        self.cartItem = cartItem
        self.delegate = delegate
        
        cartItemProductName.text = cartItem.name
        cartItemSize.text = cartItem.size
        cartItemProductPrize.text = cartItem.price.removeZerosFromEnd()
        cartItemQuantity.text = String(cartItem.quantity)
        cartItemImage.loadImage(url: URL(string: cartItem.image[0]))
        
        // Adding tap gesture recognizer to the UIView
        let decreaseIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapDecrease))
        decreaseIcon.addGestureRecognizer(decreaseIconTapGesture)
        decreaseIcon.isUserInteractionEnabled = true
        
        // Adding tap gesture recognizer to the UIView
        let increaseIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapIncrease))
        increaseIcon.addGestureRecognizer(increaseIconTapGesture)
        increaseIcon.isUserInteractionEnabled = true
        
        // Adding tap gesture recognizer to the UIView
        let deleteIconTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapDelete))
        deleteIcon.addGestureRecognizer(deleteIconTapGesture)
        deleteIcon.isUserInteractionEnabled = true
    }
    
    // MARK: - Action
    @objc func onTapDecrease() {
        if let cartItem {
            if cartItem.quantity > 1 {
                cartItem.quantity = cartItem.quantity - 1
                delegate?.didTapDecrease(for: cartItem)
            }
        }
    }
    
    @objc func onTapIncrease() {
        if let cartItem {
            cartItem.quantity = cartItem.quantity + 1
            delegate?.didTapIncrease(for: cartItem)
        }
    }
    
    @objc func onTapDelete() {
        if let cartItem {
            delegate?.didTapDelete(for: cartItem)
        }
    }
}
