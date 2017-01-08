//
//  AddGroceryItemViewController.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/28/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import UIKit

class AddGroceryItemViewController: UIViewController {

    @IBOutlet var itemName: UITextField?
    @IBOutlet var itemQuantity: UITextField?
    let manager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addGroceryItem() {
        try? manager.create(data: (itemName?.text, itemQuantity?.text?.integer ?? 0))
        dismissView()
    }
    
    @IBAction override func dismissKeyboard() {
        dismissView()
    }
    
}

extension String {
    var integer: Int? {
        return Int(self)
    }
}
