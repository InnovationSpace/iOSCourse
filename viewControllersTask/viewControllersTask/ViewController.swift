import UIKit

let ControllerKey = "ControllerKey"
let ScrollControllerId = "ScrollView"
let CollectionControllerId = "CollectionView"


class ViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    
    var scrollViewController: UIViewController!;
    var collectionViewController: UIViewController!;
    
    var currentViewController: UIViewController?;
    
    override func viewDidLoad() {

        scrollViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ScrollViewController")
        collectionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CollectionViewController")
        
        let controllerID = NSUserDefaults.standardUserDefaults().valueForKey(ControllerKey)
        
        if (controllerID != nil && controllerID!.isEqualToString(ScrollControllerId)) {
            addControllerContent(scrollViewController)
        } else {
            addControllerContent(collectionViewController)
        }
    }
    
    private func addControllerContent(content: UIViewController) {
        addChildViewController(content)
        content.view.frame = containerView.bounds
        containerView.addSubview(content.view)
        content.didMoveToParentViewController(self)
        
        currentViewController = content;
    }
    
    private func removeControllerContent(content: UIViewController?) {
        if let content = content {
            content.willMoveToParentViewController(nil)
            content.view.removeFromSuperview()
            content.removeFromParentViewController()
            
            currentViewController = nil
        }
    }
    
    @IBAction func scrollButtonTapped() {
        NSUserDefaults.standardUserDefaults().setValue(ScrollControllerId, forKey: ControllerKey)
        
        removeControllerContent(currentViewController)
        addControllerContent(scrollViewController)
    }
    
    @IBAction func collectionViewButtonTapped() {
        NSUserDefaults.standardUserDefaults().setValue(CollectionControllerId, forKey: ControllerKey)
        removeControllerContent(currentViewController)
        addControllerContent(collectionViewController)
    }
}

