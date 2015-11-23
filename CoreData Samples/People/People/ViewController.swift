//
//  ViewController.swift
//  People
//
//  Created by Andrejus Belovas on 19/05/15.
//  Copyright (c) 2015 Andrejus Belovas. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var people = [NSManagedObject]()
    
    var coreDataStack: CoreDataStack {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.coreDataStack
    }
    
    var managedContext: NSManagedObjectContext {
        return coreDataStack.context
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updatePeopleList()
    }
    
    // MARK: UITableViewDataSource
    func updatePeopleList() {
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let fetchResult = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let result = fetchResult {
                self.people = result
            }
        }
        catch let error as NSError {
            print("Couldnot fetch. Error: \(error)")
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let person = self.people[indexPath.row]
            managedContext.deleteObject(person)
            coreDataStack.saveContext()
            self.updatePeopleList()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        let person = people[indexPath.row]
        cell.textLabel!.text = person.valueForKey("name") as? String
        return cell
    }
    
    func saveName(name: String) {
        
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "name")
        
        coreDataStack.saveContext()
        
        people.append(person)
        
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



