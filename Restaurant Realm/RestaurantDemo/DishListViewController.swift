//
//  ViewController.swift
//  RestaurantDemo
//
//  Created by Cristian Olteanu on 14/03/2018.
//  Copyright © 2018 Cristian Olteanu. All rights reserved.
//

import UIKit
import SwiftRangeSlider
import RealmSwift

class DishListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var slider: RangeSlider!

    var allDishes: [Dish] = [Dish]()
    var soups: [Dish] = [Dish]()
    var solids: [Dish] = [Dish]()

    override func viewDidAppear(_ animated: Bool) {
        slider.lowerValue = 1.0
        slider.upperValue = 100.0
        let realm = try! Realm()
        allDishes = Array(realm.objects(Dish.self).sorted(byKeyPath: "name"))
        soups = allDishes.filter { dish -> Bool in
            if dish.section?.name == "Soups" {
                return true
            } else {
                return false
            }
        }
        solids = allDishes.filter { dish -> Bool in
            if dish.section?.name == "Solids" {
                return true
            } else {
                return false
            }
        }
        tableView.reloadData()
    }

    @IBAction func sliderValueChanged(_ slider: RangeSlider) {
        let maxPrice = Int(slider.upperValue)
        let minPrice = Int(slider.lowerValue)

        soups = allDishes.filter { dish -> Bool in
            if dish.price <= maxPrice && dish.price >= minPrice && dish.section?.name == "Soups" {
                return true
            } else {
                return false
            }
        }
        solids = allDishes.filter { dish -> Bool in
            if dish.price <= maxPrice && dish.price >= minPrice && dish.section?.name == "Solids" {
                return true
            } else {
                return false
            }
        }
        tableView.reloadData()
    }

    @IBAction func pressedAddButton(_ sender: AnyObject) {
        let addDishViewController = storyboard?.instantiateViewController(withIdentifier: "addDish") as! AddDishViewController
        present(addDishViewController, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource & UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Soups"
        } else {
            return "Solids"
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return soups.count
        } else {
            return solids.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dish: Dish = {
            if indexPath.section == 0 {
                return soups[indexPath.row]
            } else {
                return solids[indexPath.row]
            }
        }()
        let dishCell = tableView.dequeueReusableCell(withIdentifier: "dishCell") as! DishTableViewCell
        
        dishCell.nameLabel.text = dish.name
        dishCell.dishImageView.image = UIImage.init(data: dish.imageData)
        dishCell.priceLabel.text = "price: \(dish.price)"

        return dishCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedDish: Dish = {
            if indexPath.section == 0 {
                return soups[indexPath.row]
            } else {
                return solids[indexPath.row]
            }
        }()

        let dishDetailViewController = storyboard?.instantiateViewController(withIdentifier: "dishDetail") as! DishDetailViewController
        dishDetailViewController.dish = selectedDish

        navigationController?.pushViewController(dishDetailViewController, animated: true)
    }
}

