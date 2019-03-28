//
//  Todo.swift
//  TODORequest
//
//  Created by Miriam Costan on 27/03/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import Foundation

class Todo: Decodable {
    let id: Int
    let title: String
    let completed: Bool
}
