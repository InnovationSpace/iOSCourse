import UIKit

class ViewController: UIViewController {
    var appearance: AppApearance?
    
    override func viewDidLoad() {
        view.backgroundColor = appearance?.defaultBackgroundColor()
    }
}

