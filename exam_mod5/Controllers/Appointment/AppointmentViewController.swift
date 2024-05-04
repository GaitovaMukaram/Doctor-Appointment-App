import UIKit
import FirebaseDatabase

class AppointmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var appointments = [Appointment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAppointments()
    }
    
    func loadAppointments() {
        let ref = Database.database().reference().child("appointments")
        ref.observe(.value, with: { snapshot in
            self.appointments.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let dict = child.value as? [String: Any],
                   let doctorName = dict["doctorName"] as? String,
                   let doctorPosition = dict["doctorPosition"] as? String,
                   let appointmentDate = dict["appointmentDate"] as? String {
                    let appointment = Appointment(doctorName: doctorName, doctorPosition: doctorPosition, appointmentDate: appointmentDate)
                    self.appointments.append(appointment)
                }
            }
            self.table.reloadData()
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTableViewCell") as! AppointmentTableViewCell
        let appointment = appointments[indexPath.row]
        cell.fullnameDoctorLbl.text = appointment.doctorName
        cell.medicalPositionLbl.text = appointment.doctorPosition
        cell.dateAppointmentLbl.text = appointment.appointmentDate
        return cell
    }
}
