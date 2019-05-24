import CoreData
import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var password: UITextField!
    
    
    @IBAction func login(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "username = %@", username.text!)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                let user = result[0] as! User
                if user.password == password.text {
                    status.text = "Login successful!"
                    return
                } else {
                    status.text = "Wrong password!"
                    return
                }
            }
        } catch {
            print("Error")
        }
    }
}
