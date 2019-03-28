//
//  DishTableViewCell.swift
//  RestaurantDemo
//
//  Created by Cristian Olteanu on 14/03/2018.
//  Copyright © 2018 Cristian Olteanu. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
