import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_phoneNumber: UITextField!
    @IBOutlet weak var txt_city: UITextField!
    @IBOutlet weak var txt_streetAddress1: UITextField!
    @IBOutlet weak var txt_streetAddress2: UITextField!
    @IBOutlet weak var txt_state: UITextField!
    @IBOutlet weak var btn_remove: UIBarButtonItem!
    
    var contact : Contact? // reference to contact. If is nil, means that is a new contact
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if contact not is nil to fill all fields
        txt_firstName.text = contact?.firstName
        txt_lastName.text = contact?.lastName
        txt_phoneNumber.text = contact?.phoneNumber
        txt_city.text = contact?.city
        txt_streetAddress1.text = contact?.streetAddress1
        txt_streetAddress2.text = contact?.streetAddress2
        txt_state.text = contact?.state
        
        if (contact == nil){
            // when is a new contact, i'm gonna hide the remove button
            btn_remove.isEnabled = false
            btn_remove.tintColor = nil
            btn_remove.title = ""
        }
    }
    
    // Method called when the user press over cancel button.
    @IBAction func cancel(_ sender: Any) {
        // close the current scene
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // Method called when the user press over done button and modify the core data adding a new contact or modifying an existing one.
    @IBAction func save(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if contact == nil {
            // if is nil i need to create a new contact new contact
            self.contact = Contact.getNewInstance(context)
        }
        
        // add data to contact object
        self.contact?.firstName = txt_firstName.text!
        self.contact?.lastName = txt_lastName.text!
        self.contact?.phoneNumber = txt_phoneNumber.text!
        self.contact?.city = txt_city.text!
        self.contact?.streetAddress1 = txt_streetAddress1.text!
        self.contact?.streetAddress2 = txt_streetAddress2.text!
        self.contact?.state = txt_state.text!
        self.contact?.zipCode = "";
        self.contact?.save(context)
        
        // save
        self.contact?.save(context)
        
        // close the current scene
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    // remove a contact from list and core data
    @IBAction func remove(_ sender: Any) {
        let alert = UIAlertController(title: "Do you want to remove contact?", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Remove", style: .default, handler: { action in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDelegate.persistentContainer.viewContext
            self.contact?.remove(context)
            
            // close the current scene
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true)
    }
}
