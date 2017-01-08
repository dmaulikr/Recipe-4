//
//  GroceryItem+CoreDataProperties.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/28/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import Foundation
import CoreData

extension GroceryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroceryItem> {
        return NSFetchRequest<GroceryItem>(entityName: "GroceryItem");
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemQuantity: Int16
    @NSManaged public var groceryList: GroceryList?

}
