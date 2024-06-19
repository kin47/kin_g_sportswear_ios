import UIKit

class CartVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutSummaryContaner: UIView!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var statusText: String = ""
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        checkoutSummaryContaner.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let cartNib = UINib(nibName: "CartTableViewCell", bundle: .main)
        tableView.register(cartNib, forCellReuseIdentifier: "cart_tv_cell")
    }
    
    // MARK: - Data management
    
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
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cart_tv_cell", for: indexPath)
        return cell
    }
}
