import UIKit

class DetailDoctorViewController: UIViewController {
    
    var doctor: Doctor?
    var avatarImage: UIImage?
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var medicalPositionLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var experienceLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        print("Updating UI for doctor: \(doctor?.name ?? "Unknown") with image: \(avatarImage != nil ? "Image loaded" : "No image")")
        doctorNameLbl.text = doctor?.name
        medicalPositionLbl.text = "Терапевт"
        ageLbl.text = "\(doctor?.age ?? 0)"
        experienceLbl.text = "\(doctor?.experience ?? "")"
        phoneNumberLbl.text = "\(doctor?.phoneNumber ?? 0)"
        imgAvatar.image = avatarImage
    }
    
    func addAppointmentButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddAppointment", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAddAppointment" {
            if let addAppointmentVC = segue.destination as? AddAppointmentViewController {
                // Передача данных о враче в AddAppointmentViewController
                addAppointmentVC.doctorName = doctor?.name
                addAppointmentVC.medicalPosition = "Терапевт"
            }
        }
    }

    
    
}
