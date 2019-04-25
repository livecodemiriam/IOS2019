//
//  RestaurantListController.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 25/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit
import CoreLocation


class RestaurantListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var restaurantList: UITableView!
    var searchArea: CLPlacemark!
    
    var restaurants = [Restaurants]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantList.delegate = self
        restaurantList.dataSource = self
        
        guard let lat = searchArea.location?.coordinate.latitude, let lon = searchArea.location?.coordinate.longitude
        else {
            return
        }
        
        Requests.getRestaurants(lat: lat, lon: lon) { root in
            if let root = root {
                self.restaurants = root.restaurants ?? []
                self.restaurantList.reloadData()
                
                if self.restaurants.count == 0 {
                    self.restaurantList.isHidden = true
                }
                
            } else {
                let notification = UIAlertController(title: "Error", message: "Cannot complete search at this time. Please try again.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                notification.addAction(action)
                
                self.present(notification, animated: true, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = restaurants[indexPath.row].restaurant
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = restaurant?.name
        cell.detailTextLabel?.text = restaurant?.cuisines
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurantDetailsController = storyboard?.instantiateViewController(withIdentifier: "restaurantDetails") as! RestauranDetailsController
        restaurantDetailsController.restaurantId = Int(restaurants[indexPath.row].restaurant?.id ?? "0")
        
        navigationController?.pushViewController(restaurantDetailsController, animated: true)
    }
}
