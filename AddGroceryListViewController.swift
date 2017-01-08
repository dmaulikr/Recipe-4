//
//  AddGroceryListViewController.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/27/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import UIKit

class AddGroceryListViewController: UIViewController {

    @IBOutlet var groceryListName: UITextField!
    
    var manager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGroceryListName() {
        try? manager.create(collectionNamed: groceryListName?.text)
        dismissView()
    }

}
