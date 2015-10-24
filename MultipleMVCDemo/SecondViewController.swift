import UIKit

class SecondViewController: UIViewController {

    var delegate: SecondViewControllerDelegate? {
        didSet {
            setLabelContent()
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Second view controller")
        
        setLabelContent()
    }
    
    func setLabelContent() {
        if let delegate = self.delegate {
            let userName = delegate.userName()
            
            self.label?.text = "Hello, \(userName)!"
        }
    }

}

protocol SecondViewControllerDelegate {
    func userName() -> String
}
