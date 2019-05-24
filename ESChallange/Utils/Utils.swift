import CoreData

class Utils{
    
    // This function load the json file from local ( Assets/contacts.json ) and made the decode to can load it into the core data.
    static func loadJson(context: NSManagedObjectContext, filename fileName: String) -> Bool {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                
                decoder.userInfo[CodingUserInfoKey.context!] = context
                _ = try decoder.decode([Contact].self, from: data)
                
                try context.save()
                return true
            } catch {
                print("error:\(error)")
            }
        }
        return false
    }
    
    // Method to clean all data from a table
    static func deleteAllData(_ context: NSManagedObjectContext, entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
}
