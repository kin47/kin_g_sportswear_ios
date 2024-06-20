import UIKit

class ProfileVC: BaseVC {

    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameUI: UILabel!
    @IBOutlet weak var memberType: UILabel!
    @IBOutlet weak var coins: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var statusText: String = ""
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    var userDb: UserProtocol = UserImpl()
    var window: UIWindow?
    
    // MARK: - Closures
    
    // MARK: - Init & deinit
    
    // MARK: - View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    // MARK: - Setup
    private func setupView() {
        // Do nothing
    }
    
    // MARK: - Data management
    private func getUserInfo() {
        Task {
            let firebaseUserRes = firebaseAuth.getUserInfo()
            switch firebaseUserRes {
            case .success(let firebaseUser):
                let result = await userDb.getCurrentUser(email: firebaseUser.email ?? "")
                switch result {
                case .success(let user):
                    print("Profile VC \(user.username)")
                    usernameUI.text = user.username
                    memberType.text = user.isAdmin ? "Admin" : "User"
                    coins.text = user.coins.removeZerosFromEnd()
                    if user.avatar != nil && user.avatar != "" {
                        avatar.loadImage(url: URL(string: user.avatar!))
                    }
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
                let alert = UIAlertController(title: "Fetch Data Failed", message: "Can't get current user", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Action
    @IBAction func logout(_ sender: UIButton) {
        let result = firebaseAuth.signOut()
        switch result {
        case .success(let success):
            if success {
                let loginVC = LoginVC.create()
                SystemBoots.instance.changeRoot(window: &window, rootController: loginVC)
            }
        case .failure(_):
            // create the alert
            let alert = UIAlertController(title: "Logout Failed", message: "Please try again later", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods
}
