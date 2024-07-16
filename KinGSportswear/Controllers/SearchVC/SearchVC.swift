import UIKit

class SearchVC: BaseVC {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectCategoryLabel: UILabel!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    private var categoryPicker: TextPicker = TextPicker(nibName: "TextPicker", bundle: nil)
    var categoryValue: String?
    
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
        categoryPicker.set(list: ["Clothes", "Shoes", "Ball", "Others"])
        categoryPicker.didSelectText = { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                // Update the UITextView with the selected size
                categoryValue = response.stringValue
                selectCategoryLabel.text = categoryValue
            }
        }
    }
    
    // MARK: - Data management
    
    // MARK: - Action
    @IBAction func onTapSelectCategory(_ sender: UIButton) {
        present(categoryPicker, animated: true, completion: {
            self.categoryPicker.showWithAnimation()
        })
    }
    
    @IBAction func onTapRemoveSearchFilter(_ sender: UIButton) {
        searchBar.text = ""
        categoryValue = nil
    }
    
    @IBAction func onSearch(_ sender: UIButton) {
        let productListVC = ProductListVC.create()
        productListVC.hidesBottomBarWhenPushed = true
        productListVC.searchTitle = searchBar.text
        productListVC.searchCategory = categoryValue?.lowercased()
        navigationController?.pushViewController(productListVC, animated: true)
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods

}
