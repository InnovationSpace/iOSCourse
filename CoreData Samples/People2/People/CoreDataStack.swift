//
//  CoreDataStack.swift
//  People
//
//  Created by Andrejus Belovas on 23/11/15.
//  Copyright © 2015 Andrejus Belovas. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    let coordinator : NSPersistentStoreCoordinator
    let model : NSManagedObjectModel
    let context : NSManagedObjectContext
    var store : NSPersistentStore?
    
    func applicationDocDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        let urls = fileManager.URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return urls.first!
    }
    
    init() {
        let bundle = NSBundle.mainBundle()
        let modelURL = bundle.URLForResource("People", withExtension: "momd")
        
        model = NSManagedObjectModel(contentsOfURL: modelURL!)!
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        
        let documentsURl = applicationDocDirectory()
        
        let storeURL = documentsURl.URLByAppendingPathComponent("People")
        
        do {
            store = try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
        }
        catch {
            print("Error")
        }
   
    }
 
    func saveContext() {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch let error as NSError {
                print("Could not save: \(error) info: \(error.userInfo)")
            }
        }
    }
    
}
