//
//  RestaurantDetailsController.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 25/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit
import SafariServices

class RestauranDetailsController: UIViewController {
    var restaurantId: Int!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantRating: UILabel!
    @IBOutlet weak var restaurantCost: UILabel!
    @IBOutlet weak var restaurantLocation: UILabel!
    
    var location: Address?
    var name: String?
    var res_url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Requests.getRestaurantDetails(restaurantID: restaurantId) { res in
            if let res = res {
                self.location = res.location
                self.restaurantName.text = res.name
                self.name = res.name
                self.restaurantRating.text = "Rating: " + (res.userRating?.rating ?? "No ratings yet")
                self.restaurantCost.text = (res.cuisines ?? "No data yet")
                self.restaurantLocation.text = res.location?.address
                self.res_url = res.url
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
    
    @IBAction func pressedOnMap(_ sender: Any) {
        let mapViewController = storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        guard let latitude = location?.latitude as? String else { return }
        guard let longitude = location?.longitude as? String else { return }
        
        
        mapViewController.lat = Double(latitude)
        mapViewController.lng = Double(longitude)
        
        present(mapViewController, animated: true, completion: nil)
    }
    @IBAction func pressedOnReviews(_ sender: Any) {
        let reviewsController = storyboard?.instantiateViewController(withIdentifier: "reviews") as! ReviewsController
        reviewsController.resId = restaurantId
        present(reviewsController, animated: true, completion: nil)
    }
    @IBAction func pressedOnShare(_ sender: Any) {
        let activityItem = "Check out this restaurant I found: " + name!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func pressedOnSafari(_ sender: Any) {
        let url = URL(string: res_url!)
        
        let safariView: SFSafariViewController = SFSafariViewController(url: url!)
        
        self.present(safariView, animated: true, completion: nil)
    }
}
