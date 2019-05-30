import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var contactTable: UITableView! // reference to table view 
    
    var contact_list: [NSManagedObject] = [] // list to manage all contact on screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        //Utils.deleteAllData(context, entity: "Contact") //  at moment is only for debug porpouse
        
        // every time that app start the json it's loading again and added into the model.
        Utils.loadJsonIfDBIsEmpty(context: context, filename: "contacts")
    }
    
    // Method called everytime that the scene appear on screen. Usefull to refres the table.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // get the context
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // retrive all data from contacts
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        request.returnsObjectsAsFaults = false
        let sort = NSSortDescriptor(key: #keyPath(Contact.firstName), ascending: true)
        request.sortDescriptors = [sort]
        do {
            contact_list = try context.fetch(request) as! [NSManagedObject]
        } catch {
            print("Failed")
        }
        
        // reload the table view
        self.contactTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show the first name into the row
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        cell.textLabel?.text  = contact_list[indexPath.row].value(forKey: "firstName") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get the next scene
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "ContactDetail") as! ContactDetailViewController
        
        // pass the contact selected and present the new scene
        detailViewController.contact = (contact_list[indexPath.row] as! Contact)
        self.present(detailViewController, animated: true, completion: nil)
    }
}

