import UIKit
import FirebaseDatabase

class AddAppointmentViewController: UIViewController {
    
    @IBOutlet weak var doctorNameLbl: UILabel!
    @IBOutlet weak var medicalPositionLbl: UILabel!
    @IBOutlet weak var datePic: UIDatePicker!
    
    var doctorName: String?
    var medicalPosition: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorNameLbl.text = doctorName
        medicalPositionLbl.text = medicalPosition
        datePic.datePickerMode = .dateAndTime
        datePic.minimumDate = Date()
    }
    
    @IBAction func addAppointmentBtn(_ sender: Any) {
        let selectedDate = datePic.date
        saveAppointment(date: selectedDate)
    }
    
    func saveAppointment(date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: date)
        
        let appointmentData: [String: Any] = [
            "doctorName": doctorNameLbl.text!,
            "doctorPosition": medicalPositionLbl.text!,
            "appointmentDate": dateString
        ]
        
        let ref = Database.database().reference().child("appointments").childByAutoId()
        ref.setValue(appointmentData) { error, _ in
            if let error = error {
                print("Error saving appointment: \(error)")
            } else {
                print("Appointment saved successfully")
                let new = self.storyboard?.instantiateViewController(identifier: "MainTabBarController") as! MainTabBarController
                new.modalPresentationStyle = .fullScreen
                self.present(new, animated: true)
            }
        }
    }
    
}
