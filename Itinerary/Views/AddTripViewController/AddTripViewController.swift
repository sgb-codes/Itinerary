//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by Simon Barrett on 07/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit
import Photos

class AddTripViewController: UIViewController {
    
    //MARK: - Global Variables and IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var doneSaving: (() -> ())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Additional UI Setup
        
        // Setup: Title Label, Camera Colour, ViewController Corners
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 26)
        cameraButton.imageView?.tintColor = .red
        imageView.layer.cornerRadius = 10
        
        // Drop Shadow on TitleLabel
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
        
        // When Edit button Tapped, change ViewController Title and Load Trip details into ViewController
        if let index = tripIndexToEdit {
            let trip = Data.tripModels[index]
            titleLabel.text = "Edit Trip"
            tripTextField.text = trip.title
            imageView.image = trip.image
        }
    }
    
    // Called when User presses Cancel Button
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    // Called when User presses Save Button
    @IBAction func save(_ sender: UIButton) {
        
        // Check Textfield is not nil and assign text to variable
         guard tripTextField.hasValue, let newTripName = tripTextField.text else { return }
        
        // If Editing Trip then update TripModel
        if let index = tripIndexToEdit {
            TripFunctions.updateTrip(at: index, title: newTripName, image: imageView.image)
        }
        // If adding a new trip then Create new trip in TripModel
        else {
        TripFunctions.createTrip(tripModel: TripModel(title: newTripName, image: imageView.image))
        }
        
        // Check Data Saved and Dismiss ViewController
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    // Helper Function that creates Photo Picker object and Displays it
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            
            // Allows user to edit the image thats picked
            myPickerController.allowsEditing = true

            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true)
        }
    }
    
    // Add Photo button pressed
    @IBAction func addPhoto(_ sender: UIButton) {
        
        //Switch statement to Confirm what Authorisation App has for the Photo Picker
        /* (If Creating this feature for another app make sure to add the Request to plist: Privacy - Photo Library Usage Description, with a suitable message ) */
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
                // User has already allowed App Access
            case .authorized:
                self.presentPhotoPickerController()
                
                // App unsure of Status
            case .notDetermined:
                if status == PHAuthorizationStatus.authorized {
                    self.presentPhotoPickerController()
                }
                
                // User has set Restrictions on their phone, User should know how to change this if they want
            case .restricted:
                // Create alert Explaining Restricted Status
                let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo library access is restricted and cannot be accessed.", preferredStyle: .alert)
                // Create Ok button and add to alert
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alert.addAction(okAction)
                // Show alert to user
                self.present(alert, animated: true)
                
                // User has previously denied App request to access photos
            case .denied:
                // Create alert Explaining User has previously Denied App access to Photos
                let alert = UIAlertController(title: "Photo Library Denied", message: "Photo library access was previosuly denied. Please update your Settings if you wish to change this.", preferredStyle: .alert)
                // Create Alert Button which sends User to Settings menu to change Authorisation
                let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                    DispatchQueue.main.async {
                        // Send user to Settings Menu
                        let url = URL(string: UIApplication.openSettingsURLString)!
                        UIApplication.shared.open(url, options: [:])
                        
                    }
                }
                // Create cancel button
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                // Add buttons to Alert and Present Alert
                alert.addAction(cancelAction)
                alert.addAction(goToSettingsAction)
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
                
                // Default, Needed incase Authorization cases change in future
            @unknown default:
                print("Error: PHPhotoLibrary Authorization not handled, check Switch Cases in AddTripViewController (func addPhoto())")
            }
        }
    }
    
    
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // User has picked a Photo from PhotoPicker, Set photo as Cureent ViewController and TripView Controller Cell background, Update TripModel
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Check if user has edited the Image
        if let image = info[.editedImage] as? UIImage {
            self.imageView.image = image
            // If not then use original Image
        } else if let image = info[.originalImage] as? UIImage {
            self.imageView.image = image
        }
        
        dismiss(animated: true)
    }
    
    // User has exited PhotoPicker without choosing a Photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
