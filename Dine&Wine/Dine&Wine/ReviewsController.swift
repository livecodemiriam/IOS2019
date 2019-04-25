//
//  ReviewsController.swift
//  Dine&Wine
//
//  Created by Miriam Costan on 25/04/2019.
//  Copyright © 2019 Miriam Costan. All rights reserved.
//

import UIKit
import RealmSwift

class ReviewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var reviewsTable: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var resId: Int!
    var imageData : Data!
    
    var allReviews: [Review] = [Review]()
    var reviews: [Review] = [Review]()
    
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
        allReviews = Array(realm.objects(Review.self).sorted(byKeyPath: "reviewDescription"))
        reviews = allReviews.filter { review -> Bool in
            if review.resId == resId{
                return true
            } else {
                return false
            }
        }
        reviewsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review: Review = reviews[indexPath.row]
        let reviewCell = reviewsTable.dequeueReusableCell(withIdentifier: "reviewCell") as! ReviewsTableViewCell 
        
        reviewCell.descriptionLabel.text = review.reviewDescription
        reviewCell.reviewImageView.image = UIImage.init(data: review.imageData)
        
        return reviewCell
    }
    @IBAction func pressedAdd(_ sender: Any) {
        guard !descriptionTextView.text!.isEmpty
            else {
                let alert = UIAlertController(title: "Description can't be empty", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        let newReview = Review()
        newReview.reviewDescription = descriptionTextView.text
        newReview.resId = resId
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(newReview)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedPhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageData = image.pngData()!
        
        picker.dismiss(animated: true, completion: nil)
    }
}

class ReviewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var reviewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

