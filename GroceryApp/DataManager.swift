//
//  DataManager.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/26/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import CoreData

enum DataError: Error {
    case BadManagedObjectContext(String)
    case BadEntity(String)
}

class DataManager {
    static var shared: DataManager = DataManager()
    
    var managedObjectContext: NSManagedObjectContext?
    
    var groceryItems: [GroceryItem]
    var groceryItemCount: Int {
        return groceryItems.count
    }
    
    var groceryLists: [GroceryList]
    var groceryListCount: Int {
        return groceryLists.count
    }
    
    
    var selectedGroceryItemIndex: Int
    var selectedGroceryListIndex: Int
    
    private init() {
        groceryItems = []
        groceryLists = []
        selectedGroceryItemIndex = -1
        selectedGroceryListIndex = -1
    }
    
}
extension DataManager {
    
    func loadGroceryListData() {
        groceryLists = fetch()
    }
    
    func create(collectionNamed name: String?) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The Managed Object Context was nil")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryList", in: ctx) else {
            throw DataError.BadEntity("The entity description was bad")
        }
        
        let obj = GroceryList(entity: entity, insertInto: ctx)
        obj.name = name
        
        try? save()
    }
    
    func getGroceryListName(from indexPath: IndexPath) -> String? {
        return groceryLists.value(at: indexPath.row)?.name
    }
}

extension DataManager {
    
    func loadGroceryItemData() {
        let selectedGroceryList = groceryLists.value(at: selectedGroceryListIndex)
        groceryItems = selectedGroceryList?.groceryItems?.flatMap { item in
            return item as? GroceryItem
        } ?? []
    }
    
    func create(data: (itemName: String?, itemQuantity: Int)) throws {
        guard let ctx = managedObjectContext else {
            throw DataError.BadManagedObjectContext("The Managed Object Context was nil")
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "GroceryItem", in: ctx) else {
            throw DataError.BadEntity("The entity description was bad")
        }
        
        let obj = GroceryItem(entity: entity, insertInto: ctx)
        obj.itemName = data.itemName
        obj.itemQuantity = Int16(data.itemQuantity)
        obj.groceryList = groceryLists.value(at: selectedGroceryListIndex)
        
        try? save()
    }

    
    func getGroceryItems(from indexPath: IndexPath) -> (itemName: String?, itemQuantity: Int)? {
        guard let item = groceryItems.value(at: indexPath.row) else {
            return nil
        }
        
        return (item.itemName, Int(item.itemQuantity))
    }
    
    func getSelectedGroceryItem() -> (itemName: String?, itemQuantity: Int)? {
        guard let item = groceryItems.value(at: selectedGroceryItemIndex) else {
            return nil
        }
        return (item.itemName, Int(item.itemQuantity))
    }

    
}


extension DataManager {
    func fetch<T: NSManagedObject>() -> [T] {
        var result: [T]? = nil
        managedObjectContext?.performAndWait { [weak self] in
            do {
                result = try self?.executeFetchRequest()
            }
            catch {
                print(error)
            }
        }
        return result ?? []
    }
    
    private func executeFetchRequest<T: NSManagedObject>() throws -> [T]? {
        let request = T.fetchRequest()
        return try request.execute() as? [T]
    }

    func save() throws {
        try managedObjectContext?.save()
    }
}
