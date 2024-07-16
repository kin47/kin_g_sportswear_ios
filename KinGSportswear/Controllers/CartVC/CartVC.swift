import UIKit

class CartVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutSummaryContaner: UIView!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var statusText: String = ""
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    var cartDb: CartProtocol = CartImpl()
    var cartItems: [Cart] = []
    var totalItemInt: Int = 0
    var totalPriceDouble: Double = 0
    var chosenItem: Cart?
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCartItems()
    }
    
    // MARK: - Setup
    private func setupView() {
        checkoutSummaryContaner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let cartNib = UINib(nibName: "CartTableViewCell", bundle: .main)
        tableView.register(cartNib, forCellReuseIdentifier: "cart_tv_cell")
    }
    
    // MARK: - Data management
    private func getCartItems() {
        Task {
            IndicatorViewer.show()
            let firebaseUserRes = firebaseAuth.getUserInfo()
            switch firebaseUserRes {
            case .success(let firebaseUser):
                let result = await cartDb.getCart(userEmail: firebaseUser.email ?? "")
                switch result {
                case .success(let cartItems):
                    self.cartItems = cartItems
                    for item in cartItems {
                        totalItemInt += item.quantity
                        totalPriceDouble += (item.price * Double(item.quantity))
                    }
                    totalItems.text = String(totalItemInt)
                    totalPrice.text = totalPriceDouble.removeZerosFromEnd()
                    tableView.reloadData()
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
                let alert = UIAlertController(title: "Fetch Data Failed", message: "Can't get cart items", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    func deleteCartItem(action: UIAlertAction) {
        if let chosenItem {
            Task {
                let res = await cartDb.deleteItemInCart(cartId: chosenItem.cartItemId)
                switch res {
                case .success(_):
                    print("Delete success")
                    totalItemInt -= chosenItem.quantity
                    totalPriceDouble -= (chosenItem.price * Double(chosenItem.quantity))
                    totalItems.text = String(totalItemInt)
                    totalPrice.text = totalPriceDouble.removeZerosFromEnd()
                    cartItems = cartItems.filter{ $0.cartItemId != chosenItem.cartItemId }
                    tableView.reloadData()
                case .failure(_):
                    // create the alert
                    let alert = UIAlertController(title: "Delete Data Failed", message: "Can't delete item from cart", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: - Action
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods
}

extension CartVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell: \(indexPath.row)")
    }
}

extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart_tv_cell", for: indexPath) as! CartTableViewCell
        cell.configure(cartItem: cartItems[indexPath.row], delegate: self)
        return cell
    }
}

extension CartVC: CartTableViewCellDelegate {
    func didTapDelete(for cartItem: Cart) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to remove this product from your cart", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: deleteCartItem))
        chosenItem = cartItem
        self.present(alert, animated: true, completion: nil)
    }
    
    func didTapIncrease(for cartItem: Cart) {
        totalItemInt += 1
        totalPriceDouble += cartItem.price
        totalItems.text = String(totalItemInt)
        totalPrice.text = totalPriceDouble.removeZerosFromEnd()
        tableView.reloadData()
        Task {
            let res = await cartDb.updateCart(cart: cartItem)
            switch res {
            case .success(_):
                print("Update success")
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Update Data Failed", message: "Can't update quantity", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func didTapDecrease(for cartItem: Cart) {
        totalItemInt -= 1
        totalPriceDouble -= cartItem.price
        totalItems.text = String(totalItemInt)
        totalPrice.text = totalPriceDouble.removeZerosFromEnd()
        tableView.reloadData()
        Task {
            let res = await cartDb.updateCart(cart: cartItem)
            switch res {
            case .success(_):
                print("Update success")
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Update Data Failed", message: "Can't update quantity", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
