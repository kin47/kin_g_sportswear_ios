import UIKit

class CoreVC: UITabBarController {
    // MARK: - Outlets
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var statusText: String = ""
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
    }
    
    // MARK: tab setup
    private func setupTabs() {
        let home  = createNav(title: "Home", image: UIImage(systemName: "house.fill")!, vc: HomeVC())
        let search  = createNav(title: "Search", image: UIImage(systemName: "magnifyingglass")!, vc: SearchVC())
        let cart  = createNav(title: "Cart", image: UIImage(systemName: "cart.fill")!, vc: CartVC())
        let profile  = createNav(title: "Profile", image: UIImage(systemName: "person.fill")!, vc: ProfileVC())
        self.setViewControllers([home, search, cart, profile], animated: true)
    }
    
    private func createNav(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        nav.viewControllers.first?.navigationItem.title = title + " nav"
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        return nav;
    }
    
    // MARK: - Data management
    
    
    // MARK: - Action
    
    
    // MARK: - Update UI
    
    
    // MARK: - Supporting methods
    

}
