import UIKit
import FirebaseDatabase
import FirebaseStorage

class ListDoctorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var table: UITableView!
    var doctors = [Doctor]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        loadDoctorsData()
    }
    
    func loadDoctorsData() {
        let ref = Database.database().reference(withPath: "doctors/therapist")
        ref.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let dict = child.value as? [String: Any],
                   let age = dict["age"] as? Int,
                   let avatar = dict["avatar"] as? String,
                   let experience = dict["experience"] as? String,
                   let phone = dict["phone"] as? Int {
                    let doctor = Doctor(name: child.key, avatarURL: avatar, age: age, experience: experience, phoneNumber: phone)
                    self.doctors.append(doctor)
                }
            }
            self.table.reloadData()
        })
    }
    
    func loadAvatar(for index: Int, completion: @escaping (UIImage?) -> Void) {
        let doctor = doctors[index]
        let storageRef = Storage.storage().reference().child("avatars").child(doctor.avatarURL)
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error loading image: \(error)")
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.doctors[index].avatarImage = image
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListDoctorsTableViewCell", for: indexPath) as! ListDoctorsTableViewCell
        let doctor = doctors[indexPath.row]
        cell.fullnameDoctorLbl.text = doctor.name
        cell.medicalPositionLbl.text = "Терапевт"
        loadAvatar(for: indexPath.row) { image in
                if let currentCell = tableView.cellForRow(at: indexPath) as? ListDoctorsTableViewCell {
                    currentCell.imgAvatar.image = image
                }
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            if let indexPath = table.indexPathForSelectedRow {
                let selectedDoctor = doctors[indexPath.row]
                let detailVC = segue.destination as! DetailDoctorViewController
                detailVC.doctor = selectedDoctor
                detailVC.avatarImage = selectedDoctor.avatarImage
            }
        }
    }
}

