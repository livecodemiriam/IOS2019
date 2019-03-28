//
//  Post.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
