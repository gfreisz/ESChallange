import CoreData

// Class to can manage all contacts from Core Data (NSManagedObject) and JSON ( Decodable )
class Contact : NSManagedObject, Decodable {
    @NSManaged var contactID: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var phoneNumber: String
    @NSManaged var state: String
    @NSManaged var city: String
    @NSManaged var streetAddress1: String
    @NSManaged var streetAddress2: String
    @NSManaged var zipCode: String

    // enum to reference the json with the managed vars
    enum CodingKeys: String, CodingKey{
        case contactID = "contactID"
        case firstName = "firstName"
        case lastName = "lastName"
        case phoneNumber = "phoneNumber"
        case state = "state"
        case city = "city"
        case streetAddress1 = "streetAddress1"
        case streetAddress2 = "streetAddress2"
        case zipCode = "zipCode"
    }

    // this method work on the parse of json and load all data into the object
    required convenience init(from decoder: Decoder) throws {
        // Create NSEntityDescription with NSManagedObjectContext
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Contact", in: managedObjectContext) else {
                fatalError("Failed to decode Contact!")
        }
        self.init(entity: entity, insertInto: managedObjectContext) // prepare de entity object to can save all data
        
        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.contactID = try values.decode(String.self, forKey: .contactID)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.phoneNumber = try values.decode(String.self, forKey: .phoneNumber)
        self.state = try values.decode(String.self, forKey: .state)
        self.city = try values.decode(String.self, forKey: .city)
        self.streetAddress1 = try values.decode(String.self, forKey: .streetAddress1)
        self.streetAddress2 = try values.decode(String.self, forKey: .streetAddress2)
        self.zipCode = try values.decode(String.self, forKey: .zipCode)
    }
    
    // return a new instance (empty) for a contact
    static func getNewInstance(_ context: NSManagedObjectContext) -> Contact{
        let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context)!
        let ret = NSManagedObject(entity: entity, insertInto: context) as! Contact
        
        return ret;
    }
    
    // save the contact into the core data
    func save(_ context: NSManagedObjectContext){
        do {
            try context.save()
        } catch {
            print("error:\(error)")
        }
    }
    
    // remove a contact
    func remove(_ context: NSManagedObjectContext){
        context.delete(self)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
