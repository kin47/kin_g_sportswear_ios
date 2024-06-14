import UIKit

class RegisterVC: BaseVC {
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
    @IBAction func goToLoginClicked(_ sender: UIButton) {
        self.pop()
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        if passwordTextField.text == nil || passwordTextField.text!.count < 8 {
            // create the alert
            let alert = UIAlertController(title: "Register Failed", message: "Password must have at least 8 characters", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
        Task { @MainActor in
            let result = await firebaseAuth.signUpWithEmailAndPassword(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
            switch result {
            case .success(let success):
                let coreVC = CoreVC.create()
                SystemBoots.instance.changeRoot(window: &window, rootController: coreVC)
            case .failure(_):
                // create the alert
                let alert = UIAlertController(title: "Register Failed", message: "Error System", preferredStyle: UIAlertController.Style.alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    // MARK: - Update UI
    
    // MARK: - Supporting methods


}
