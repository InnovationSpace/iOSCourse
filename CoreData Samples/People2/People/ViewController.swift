//
//  ViewController.swift
//  People
//
//  Created by Andrejus Belovas on 19/05/15.
//  Copyright (c) 2015 Andrejus Belovas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedResultsController: NSFetchedResultsController!

    var coreDataStack: CoreDataStack {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.coreDataStack
    }
    
    var managedContext: NSManagedObjectContext {
        return coreDataStack.context
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do  {
            try fetchedResultsController.performFetch()
        }
        catch let error as NSError {
            print("Couldnot fetch. Error: \(error)")
        }
        
        
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        default:
            break
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let person = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            managedContext.deleteObject(person)
            coreDataStack.saveContext()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        let person = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        cell.textLabel!.text = person.valueForKey("name") as? String
        return cell
    }
    
    func saveName(name: String) {
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        
        coreDataStack.saveContext()
    }
    
    @IBAction func addName(sender: UIBarButtonItem) {
            let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
                let textField = alert.textFields![0] 
                self.saveName(textField.text!)
                self.tableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction) -> Void in
            }
            
            alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            }
            
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            presentViewController(alert, animated: true, completion: nil)
    }
}
