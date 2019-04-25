//
//  ViewController.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 23/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit
import CoreLocation

class FinderController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchButton.isEnabled = false
        cityField.delegate = self
    }
    
    @IBAction func buttonPushed(_ sender: Any) {
        let address = cityField.text
        CLGeocoder().geocodeAddressString(address!) { placemarks, error in
            if error != nil {
                debugPrint(error.debugDescription)
                return
            }
            guard let placemark = placemarks?.first else {
                print("Location not found")
                return
            }
            let restaurantListController = self.storyboard?.instantiateViewController(withIdentifier: "restaurantList") as! RestaurantListController
            restaurantListController.searchArea = placemark
            
            self.navigationController?.pushViewController(restaurantListController, animated: true)
        }
    }
    
    @IBAction func surprisePushed(_ sender: Any) {
        self.performSegue(withIdentifier: "toSurprise", sender: self)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
        
        return true
    }
    
}

