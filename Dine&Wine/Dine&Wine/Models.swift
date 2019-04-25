//
//  Models.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 25/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import Foundation
import RealmSwift

class Review: Object {
    @objc dynamic var resId: Int = 0
    @objc dynamic var imageData: Data =  UIImage(named:"none")!.pngData()!
    @objc dynamic var reviewDescription: String = ""
}

struct Root: Decodable {
    let location: LocationCode?
    let restaurants: [Restaurants]?
    
    enum CodingKeys: String, CodingKey {
        case location
        case restaurants = "nearby_restaurants"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decode(LocationCode.self, forKey: .location)
        restaurants = try values.decode([Restaurants].self, forKey: .restaurants)
    }
}

struct LocationCode: Decodable {
    let title: String?
}

struct Restaurants: Decodable {
    let restaurant: Restaurant?
}

struct Restaurant: Decodable {
    let id: String?
    let name: String?
    let cuisines: String?
    let location: Address?
    let userRating: UserRating?
    
    private enum RestaurantCodingKeys: String, CodingKey {
        case id
        case name
        case cuisines
        case location
        case userRating = "user_rating"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: RestaurantCodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        cuisines = try values.decode(String.self, forKey: .cuisines)
        location = try values.decode(Address.self, forKey: .location)
        userRating = try values.decode(UserRating.self, forKey: .userRating)
        
    }
}

struct Address: Decodable {
    let address: String?
    let latitude: String?
    let longitude: String?
}

struct UserRating: Decodable {
    let rating: String?
    let votes: String?
    
    private enum UserCodingKeys: String, CodingKey {
        case rating = "aggregate_rating"
        case votes
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: UserCodingKeys.self)
        rating = try values.decode(String.self, forKey: .rating)
        votes = try values.decode(String.self, forKey: .votes)
    }
}
