//
//  User.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class User: Decodable {
    let name: String
    let username: String
    let company: UserCompany
    let address: UserAddress
}
