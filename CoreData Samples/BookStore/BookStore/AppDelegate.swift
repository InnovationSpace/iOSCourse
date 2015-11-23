//
//  AppDelegate.swift
//  BookStore
//
//  Created by Andrejus Belovas on 23/11/15.
//  Copyright © 2015 Andrejus Belovas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func insertSomeData() {
                     do {
                    let category = try self.managedObjectContext.executeFetchRequest(NSFetchRequest(entityName: "BookCategory")).last as! BookCategory?
                    if let category = category {
                    for i in 5..<10 {
                        managedObjectContext.undoManager?.beginUndoGrouping()
                    let book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: self.managedObjectContext) as! Book
                    book.title = "The \(i)th book"
                    book.price = i
                    let booksRelation = category.valueForKeyPath("books") as! NSMutableSet
                    booksRelation.addObject(book)
                        managedObjectContext.undoManager?.endUndoGrouping()
                    }
                        managedObjectContext.undoManager?.undo()
                        
                    saveContext()
                    }                    }
                    catch let error as NSError {
        print("Error fetching: \(error)")
                    }
    }
    
    func deleteAllObjects(entityName: String) {
        let fetchRequest = NSFetchRequest(entityName: entityName)
        do {
        let objects = try self.managedObjectContext.executeFetchRequest(fetchRequest)
        
        for object in objects as! [NSManagedObject] {
            self.managedObjectContext.deleteObject(object)
        }
        
            try self.managedObjectContext.save()
        } catch let error as NSError {
            print("Error deleting \(entityName) - error:\(error)")
        }
    }
    
    func initStore() {
        let fiction = NSEntityDescription.insertNewObjectForEntityForName("BookCategory",
            inManagedObjectContext: self.managedObjectContext) as! BookCategory
        fiction.name = "Fiction"
        
        let biography = NSEntityDescription.insertNewObjectForEntityForName("BookCategory",
                inManagedObjectContext: self.managedObjectContext) as! BookCategory
        biography.name = "Biography"
        
        let book1 = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext:
            self.managedObjectContext) as! Book
        book1.title = "The first book"
        book1.price = 10
        
        let book2 = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext:
            self.managedObjectContext) as! Book
        book2.title = "The second book"
        book2.price = 15
        
        let book3 = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext:
            self.managedObjectContext) as! Book
        book3.title = "The third book"
        book3.price = 10
        
        let fictionRelation = fiction.mutableSetValueForKeyPath("books")
        fictionRelation.addObject(book1)
        fictionRelation.addObject(book2)
        
        let biographyRelation = biography.mutableSetValueForKeyPath("books")
        biographyRelation.addObject(book3)
        
        self.saveContext()
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//            deleteAllObjects("Book")
//            deleteAllObjects("BookCategory")
//            
//            initStore()
//            insertSomeData()
            
            showExampleData()
            
        // Override point for customization after application launch.
        return true
    }

    func showExampleData() {
            
            let fetchRequest = NSFetchRequest(entityName: "BookCategory")
        do {
            let categories = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for category in categories as! [BookCategory] {
                print("Bargains for category: \(category.name!)")
                let bargainBooks = category.valueForKey("bargainBooks") as! [Book!]
                for book in bargainBooks {
                print("Title: \(book.title!), price: \(book.price!)")
                }
            }
        } catch let error as NSError {
            print("Error fetching: \(error)")
        }
            
            /*
            
            let fetchRequest = NSFetchRequest(entityName: "Book")
            let count = self.managedObjectContext.countForFetchRequest(fetchRequest, error: nil)
            
            print("Books total: \(count)")
            
            
            let exprTitle = NSExpression(forKeyPath: "title")
        let exprValue = NSExpression(forConstantValue: "The first book")
        let predicate = NSComparisonPredicate(leftExpression: exprTitle, rightExpression: exprValue, modifier: .DirectPredicateModifier, type: .EqualToPredicateOperatorType, options: .CaseInsensitivePredicateOption)
        fetchRequest.predicate = predicate
            //fetchRequest.predicate = NSPredicate(format: "title = 'The first book'")
            
            do {
            let books = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            for book in books as! [Book] {
            print("Title: \(book.title!), price: \(book.price!)")
            }
        } catch let error as NSError {
            print("Error showing data: \(error)")
            }

*/
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "testing.BookStore" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("BookStore", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
    let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
            managedObjectContext.undoManager = NSUndoManager()
            managedObjectContext.undoManager?.groupsByEvent = false
            
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

