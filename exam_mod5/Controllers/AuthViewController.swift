import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var loginTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let e = loginTf.text!
        let p = passwordTf.text!
        if (e.isEmpty || p.isEmpty) {
            let alert = UIAlertController(title: "Ошибка", message: "Логин или пароль не может быть пустой", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: true)
        }
        else {
            Auth.auth().signIn(withEmail: e, password: p) {
                user, error in
                if let e = error {
                    let alert = UIAlertController(title: "Ошибка", message: e.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                    return
                }
                if let _ = user {
                    let new = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
                    new.modalPresentationStyle = .fullScreen
                    self.present(new, animated: true)
                }
            }
        }
    }
}


