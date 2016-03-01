//
//  Grocery+CoreDataProperties.swift
//  iCloudSpecialTopics
//
//  Created by Victor Hawley on 2/29/16.
//  Copyright © 2016 Victor Hawley Jr. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Grocery {

    @NSManaged var name: String?
    @NSManaged var price: NSNumber?
    @NSManaged var purchased: NSNumber?
    @NSManaged var quantity: NSNumber?

}
