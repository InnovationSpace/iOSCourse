import UIKit

class StaticTableViewController: UITableViewController {

    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Trecias"
    }
}
