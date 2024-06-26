import UIKit

class SearchVC: BaseVC {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    
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
        // Do nothing
    }
    
    // MARK: - Data management
    
    // MARK: - Action
    @IBAction func onSearch(_ sender: UIButton) {
        let productListVC = ProductListVC.create()
        productListVC.hidesBottomBarWhenPushed = true
        productListVC.searchTitle = searchBar.text
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods


}
