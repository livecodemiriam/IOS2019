//
//  EditDishViewController.swift
//  RestaurantDemo
//
//  Created by Miriam Costan on 28/03/2019.
//  Copyright © 2019 Cristian Olteanu. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class EditDishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var dish: Dish!
    var imageData: Data!
    
    @IBOutlet weak var sectionSegment: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var charactersLabel: UILabel!
    @IBAction func pressedColseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pressedPhoto(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageData = image.pngData()!
        
        picker.dismiss(animated: true, completion: nil)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 100
    }
    func textViewDidChange(_ textView: UITextView) {
        let charactersLeft = 100 - textView.text.count
        charactersLabel.text = "Characters remaining: " + String(charactersLeft)
        if charactersLeft == 0 {
            charactersLabel.textColor = UIColor.red
        } else {
            charactersLabel.textColor = UIColor.black
        }
    }
    @IBAction func pressedUpdate(_ sender: Any) {
        guard !nameTextField.text!.isEmpty
            else {
                let alert = UIAlertController(title: "Name can't be empty", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        guard !priceTextField.text!.isEmpty
            else {
                let alert = UIAlertController(title: "Price can't be empty", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        guard !descriptionTextView.text!.isEmpty
            else {
                let alert = UIAlertController(title: "Description can't be empty", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                
                return
        }
        guard let price = Int(priceTextField.text!) else {
            let alert = UIAlertController(title: "Price has to be a number", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        let realm = try! Realm()
        try! realm.write {
            dish.name = nameTextField.text!
            dish.price = price
            dish.dishDescription = descriptionTextView.text
            dish.imageData = imageData
            
            var dishSection : DishSection
            let realm = try! Realm()
            if sectionSegment.selectedSegmentIndex == 0 {
                dishSection = realm.objects(DishSection.self).filter("name == 'Soups'").first!
            } else {
                dishSection = realm.objects(DishSection.self).filter("name == 'Solids'").first!
            }
            dish.section = dishSection
        }
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = dish.name
        descriptionTextView.text = dish.dishDescription
        if dish.section!.name == "Soups" {
            sectionSegment.selectedSegmentIndex = 0
        } else {
            sectionSegment.selectedSegmentIndex = 1
        }
        priceTextField.text = String(dish.price)
        let charactersLeft = 100 - descriptionTextView.text.count
        charactersLabel.text = "Characters remaining: " + String(charactersLeft)
        imageData = dish.imageData
    }
}
