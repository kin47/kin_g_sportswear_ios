import UIKit

class ProfileVC: BaseVC {

    // MARK: - Outlets

    @IBOutlet weak var scrollView: UIScrollView!
    
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
        // Disable automatic adjustment
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    // MARK: - Setup
    private func setupView() {
        // Do nothing
    }
    
    // MARK: - Data management
    
    // MARK: - Action
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods


}
