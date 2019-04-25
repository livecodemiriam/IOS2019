//
//  Requests.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 24/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import Foundation
import Alamofire

class Requests {
    static func getRestaurants(lat: Double, lon: Double, completion: @escaping (Root?) -> Void) {
        
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/geocode?lat=\(lat)&lon=\(lon)") else { return }
        
        let headers: HTTPHeaders = [
            "user_key": "8869bbdc9aa90883760577c1e55e2c93",
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint("The error is " + error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else { return completion(nil) }
            
            let jsonDecoder = JSONDecoder()
            do {
                let root = try jsonDecoder.decode(Root.self, from: data)
                completion(root)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    static func getRestaurantDetails(restaurantID: Int, completion: @escaping (Restaurant?) -> Void) {
        
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/restaurant?res_id=\(restaurantID)") else { return }
        
        let headers: HTTPHeaders = [
            "user_key": "8869bbdc9aa90883760577c1e55e2c93",
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, headers: headers).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint("The error is " + error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else { return completion(nil) }
            
            let jsonDecoder = JSONDecoder()
            do {
                let restaurant = try jsonDecoder.decode(Restaurant.self, from: data)
                completion(restaurant)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
