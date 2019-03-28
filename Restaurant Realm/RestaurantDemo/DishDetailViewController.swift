//
//  DishDetailViewController.swift
//  RestaurantDemo
//
//  Created by Cristian Olteanu on 14/03/2018.
//  Copyright © 2018 Cristian Olteanu. All rights reserved.
//

import UIKit

class DishDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBAction func pressedEdit(_ sender: Any) {
        let editDishViewController = storyboard?.instantiateViewController(withIdentifier: "editDish") as! EditDishViewController
        editDishViewController.dish = self.dish
        
        present(editDishViewController, animated: true, completion: nil)
        let dishListViewController = storyboard?.instantiateViewController(withIdentifier: "menu") as! DishListViewController
        
        navigationController?.pushViewController(dishListViewController, animated: true)
    }
    
    var dish: Dish!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = dish.name
        dishImageView.image = UIImage.init(data: dish.imageData)
        descriptionTextView.text = dish.dishDescription
    }
}
