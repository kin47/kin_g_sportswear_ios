import UIKit

class LoginVC: BaseVC {

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var loginWithGoogleBtn: UIButton!
    
    // MARK: - Constraints
    
    // MARK: - Constants
    
    // MARK: - Variables
    var window: UIWindow?
    var statusText: String = ""
    var firebaseAuth: FirebaseAuthenticationProtocol = FirebaseAuthenticationImpl()
    
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
    @IBAction func login(_ sender: UIButton) {
        Task {
            IndicatorViewer.show()
            let result = await firebaseAuth.signInWithEmailAndPassword(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            switch result {
            case .success(_):
                let coreVC = CoreVC.create()
                SystemBoots.instance.changeRoot(window: &window, rootController: coreVC)
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Login Failed", message: "Wrong email or password", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            IndicatorViewer.hide()
        }
    }
    
    @IBAction func goToRegisterBtn(_ sender: UIButton) {
        RegisterVC.push()
    }
    
    // MARK: - Update UI
    
    // MARK: - Supporting methods


}
