import CoreData
import UIKit

class RegisterView: UIView {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBAction func register(_ sender: Any) {
        if password.text == confirm.text {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "username = %@", username.text!)
            do {
                let result = try managedContext.fetch(fetchRequest)
                if result.count > 0 {
                    username.text = ""
                    password.text = ""
                    confirm.text = ""
                    status.text = "Username already exists!"
                    return
                }
                //                for user in result as! [NSManagedObject] {
                //                    if (user.value(forKey: "username") as! String) == username.text! {
                //                        username.text = ""
                //                        password.text = ""
                //                        confirm.text = ""
                //                        status.text = "Username already exists!"
                //                        return
                //                    }
                //                }
            } catch {
                print("Error fetching data from CoreData!")
            }
            let user = User(context: managedContext)
            user.username = username.text
            user.password = password.text
            // Commit our changes
            do {
                try managedContext.save()
            } catch {
                print("Error saving to CoreData!")
            }
            username.text = ""
            password.text = ""
            confirm.text = ""
            status.text = "Successfully registered user: \(username.text!)"
        } else {
            password.text = ""
            confirm.text = ""
            status.text = "Password and Confirm do not match!"
            return
        }
    }
    
}
