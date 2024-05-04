import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveUser(fullName: String, email: String, phoneNumber: Int, birthDate: Date, password: String) {
        let user = UsersClass(context: context)
        user.fullname = fullName
        user.email = email
        user.phoneNumber = Int32(phoneNumber)
        user.birthdate = birthDate
        user.password = password
        
        do {
            try context.save()
            print("User saved successfully!")
        } catch {
            print("Error saving user: \(error)")
        }
    }
    
    func fetchUsers() -> [UsersClass] {
        let fetchRequest: NSFetchRequest<UsersClass> = UsersClass.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Error fetching data: \(error)")
            return []
        }
    }
    
    func deleteUser(_ user: UsersClass) {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print("Error deleting user: \(error)")
        }
    }
}

