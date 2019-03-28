//
//  UserAddress.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class UserAddress: Decodable {
    let street: String
    let city: String
    let geo: AddressGeo
}
