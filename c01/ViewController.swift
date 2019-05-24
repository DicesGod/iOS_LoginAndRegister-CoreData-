

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func login(_ sender: UIButton) {
        guard let username = self.view.viewWithTag(11) as? UITextField else {
            return
        }
        guard let password = self.view.viewWithTag(12) as? UITextField else {
            return
        }
        guard let status = self.view.viewWithTag(13) as? UILabel else {
            return
        }
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

    @IBAction func register(_ sender: UIButton) {
        guard let username = self.view.viewWithTag(21) as? UITextField else {
            return
        }
        guard let password = self.view.viewWithTag(22) as? UITextField else {
            return
        }
        guard let confirm = self.view.viewWithTag(23) as? UITextField else {
            return
        }
        guard let status = self.view.viewWithTag(24) as? UILabel else {
            return
        }
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

