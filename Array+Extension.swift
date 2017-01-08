//
//  Array+Extension.swift
//  GroceryApp
//
//  Created by Matthew Downey on 11/27/16.
//  Copyright © 2016 Matthew Downey. All rights reserved.
//

import Foundation

extension Array {
    func value(at index: Int) -> Element? {
        guard index >= 0 && index < endIndex else {
            return nil
        }
        return self[index]
    }
}
