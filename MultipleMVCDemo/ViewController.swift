import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("First view controller")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let destinationViewController = segue.destinationViewController as? SecondViewController {
            destinationViewController.delegate = self
        }
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        if let text = self.textField.text {
            if text.characters.count > 1 {
                self.performSegueWithIdentifier("SecondViewController", sender: nil)
            }
        }
    }
    
}

extension ViewController: SecondViewControllerDelegate {
    
    func userName() -> String {
        return self.textField.text!
    }
    
}
