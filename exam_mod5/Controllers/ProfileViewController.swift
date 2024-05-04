import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var birthdateLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserProfile()
    }
    
    func loadUserProfile() {
          let users = DataManager.shared.fetchUsers()
          if let currentUser = users.first {
              updateUI(with: currentUser)
          }
      }
      
      func updateUI(with user: UsersClass) {
          nameLbl.text = user.fullname
          emailLbl.text = user.email
          phoneNumberLbl.text = String(user.phoneNumber)
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          birthdateLbl.text = dateFormatter.string(from: user.birthdate!)
      }

}
