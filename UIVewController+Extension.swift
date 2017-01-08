//
//  UIVewController+Extension.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/27/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func dismissView() {
        dismiss(animated: UIView.areAnimationsEnabled, completion: nil)
    }
}
