//
//  AddDishViewController.swift
//  RestaurantDemo
//
//  Created by Cristian Olteanu on 27/03/2018.
//  Copyright © 2018 Cristian Olteanu. All rights reserved.
//

import UIKit
import RealmSwift
class AddDishViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    var imageData : Data!
    @IBOutlet private weak var sectionSegment: UISegmentedControl!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var charactersLabel: UILabel!
    
    @IBAction func pressedClose(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func pressedPhoto(_ sender: Any) {
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
    
    @IBAction func pressedAdd(_ sender: AnyObject) {
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
        
        let newDish = Dish()
        newDish.name = nameTextField.text!
        newDish.price = price
        newDish.dishDescription = descriptionTextView.text
        newDish.imageData = imageData
        
        var dishSection : DishSection
        let realm = try! Realm()
        if sectionSegment.selectedSegmentIndex == 0 {
            dishSection = realm.objects(DishSection.self).filter("name == 'Soups'").first!
        } else {
            dishSection = realm.objects(DishSection.self).filter("name == 'Solids'").first!
        }
        newDish.section = dishSection
        
        try! realm.write {
            realm.add(newDish)
        }
        dismiss(animated: true, completion: nil)
    }
    
}
