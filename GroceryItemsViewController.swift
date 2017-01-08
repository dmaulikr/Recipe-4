//
//  GroceryItemsViewController.swift
//  GroceryApp/Users/matthewddowney/Development/GroceryApp/GroceryApp.xcodeproj
//
//  Created by Matthew Downey on 11/27/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import UIKit

class GroceryItemsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var groceryItemsTableView: UITableView!
    
    let manager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.loadGroceryItemData()
        groceryItemsTableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.groceryItemCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = manager.getGroceryItems(from: indexPath)
        cell.textLabel?.text = item?.itemName
        cell.detailTextLabel?.text = "Quantity: \(item?.itemQuantity ?? 0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groceryItemsTableView.deselectRow(at: indexPath, animated: UIView.areAnimationsEnabled)
        
        manager.selectedGroceryItemIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView,
                            canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }

}
