//
//  SharedData.swift
//  boba
//
//  Created by Kenneth Zhang on 2/26/24.
//

import Foundation

class data{
    static var shared = data()
    
    var address: String = ""
    var est: Int = 0
    
    var cartItemNumber: [Int] = [0, 0, 0, 0]
    var cartName: [String] = ["Milk Tea", "Fruit Tea", "Smoothie", "Matcha"]
    var itemCost: [Int] = [6, 5, 7, 8]

    var addOrder : Bool = false;
    var cost = 0
}
