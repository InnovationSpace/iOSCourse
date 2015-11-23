//
//  Book.swift
//  BookStore
//
//  Created by Andrejus Belovas on 23/11/15.
//  Copyright © 2015 Andrejus Belovas. All rights reserved.
//

import Foundation
import CoreData

class Book: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    override func awakeFromInsert() {
        super.awakeFromInsert()
        print("Book created")
    }
    
    override func awakeFromFetch() {
        super.awakeFromFetch()
        print("Book fetched")
    }
    
}
