//
//  Book+CoreDataProperties.swift
//  BookStore
//
//  Created by Andrejus Belovas on 23/11/15.
//  Copyright © 2015 Andrejus Belovas. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String?
    @NSManaged var price: NSNumber?
    @NSManaged var category: BookCategory?

}
