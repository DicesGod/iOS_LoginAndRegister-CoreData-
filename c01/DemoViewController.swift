
import UIKit

class DemoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let registerView = Bundle.main.loadNibNamed("register", owner:self, options: nil)?.first as? RegisterView else {
            print("Error loading register view!")
            return
        }
        guard let loginView = Bundle.main.loadNibNamed("login", owner: self, options: nil)?.first as? LoginView else {
            print("Error loading login view!")
            return
        }
        
        registerView.backgroundColor = .red
        self.view.addSubview(registerView)
        
        loginView.backgroundColor = .blue
        loginView.frame.origin.x = 0
        loginView.frame.origin.y = 350
        self.view.addSubview(loginView)
        
//        loginView.loginButton.addTarget(self, action: #selector(DemoViewController.loginButton(sender:)), for: .touchUpInside)
        
        
    }
}
