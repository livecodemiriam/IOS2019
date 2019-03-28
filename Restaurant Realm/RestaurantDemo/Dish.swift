//
//  Dish.swift
//  RestaurantDemo
//
//  Created by Cristian Olteanu on 14/03/2018.
//  Copyright © 2018 Cristian Olteanu. All rights reserved.
//

import Foundation
import RealmSwift

class Dish: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var imageData: Data =  UIImage(named:"none")!.pngData()!
    @objc dynamic var dishDescription: String = ""
    @objc dynamic var section: DishSection? = nil

}

class DishSection: Object {
    @objc dynamic var name: String = ""
}

