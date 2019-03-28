//
//  UserViewController.swift
//  RequestsDemo
//
//  Created by Cristian Olteanu on 13/03/2019.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    var userId: Int!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var authorCompany: UILabel!
    @IBOutlet weak var authorAddress: UILabel!
    
    var author: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Requests.getUser(userId: userId,
                             completionHandler: { data, response, error in
                                self.author = try! JSONDecoder().decode([User].self, from: data!)[0]
                                DispatchQueue.main.async {
                                    self.authorName.text = self.author?.name
                                    self.authorUsername.text = self.author?.username
                                    self.authorCompany.text = self.author?.company.name
                                    self.authorAddress.text = self.author!.address.street + ", " +  self.author!.address.city
                                }
        })
    }

    @IBAction func pressedSeeOnMap() {
        let mapViewController = storyboard?.instantiateViewController(withIdentifier: "map") as! MapViewController
        
        mapViewController.lat = Double(author!.address.geo.lat)
        mapViewController.lng = Double(author!.address.geo.lng)
        
        present(mapViewController, animated: true, completion: nil)
    }
    
    
}
