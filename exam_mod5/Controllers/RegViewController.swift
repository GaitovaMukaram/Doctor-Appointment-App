import UIKit
import FirebaseAuth

class RegViewController: UIViewController {
    
    @IBOutlet weak var fullnameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var phoneNumberTf: UITextField!
    @IBOutlet weak var birthdateTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var rePasswordTf: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAvatarBtn(_ sender: Any) {
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        let fn = fullnameTf.text!
        let e = emailTf.text!
        let phStr = phoneNumberTf.text!
        let ph = Int(phStr)!
        let bd = birthdateTf.text!
        let p = passwordTf.text!
        let r = rePasswordTf.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        if let birthDate = dateFormatter.date(from: bd) {
            if fn.isEmpty || e.isEmpty || phStr.isEmpty || bd.isEmpty || p.isEmpty || r.isEmpty || p != r {
                let alert = UIAlertController(title: "Ошибка", message: "Проверьте введенные данные!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default))
                self.present(alert, animated: true)
            } else {
                Auth.auth().createUser(withEmail: e, password: p) { user, error in
                    if let error = error {
                        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ok", style: .default))
                        self.present(alert, animated: true)
                        return
                    }
                    if user != nil {
                        DataManager.shared.saveUser(fullName: fn, email: e, phoneNumber: ph, birthDate: birthDate, password: p)
                        let new = self.storyboard?.instantiateViewController(identifier: "AuthViewController") as! AuthViewController
                        new.modalPresentationStyle = .fullScreen
                        self.present(new, animated: true)
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Формат даты рождения неверен.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            self.present(alert, animated: true)
        }
    }
}


