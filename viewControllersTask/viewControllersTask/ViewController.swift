import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var containerView: UIView!
    
    var scrollViewController: UIViewController!;
    var collectionViewController: UIViewController!;
    
    var currentViewController: UIViewController?;
    
    override func viewDidLoad() {
        scrollViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ScrollViewController")
        collectionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("CollectionViewController")
        
        addControllerContent(scrollViewController)
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
        removeControllerContent(currentViewController)
        addControllerContent(scrollViewController)
    }
    
    @IBAction func collectionViewButtonTapped() {
        removeControllerContent(currentViewController)
        addControllerContent(collectionViewController)
    }
}

