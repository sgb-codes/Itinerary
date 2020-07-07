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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var doneSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Additional UI Setup
        
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 26)
        cameraButton.imageView?.tintColor = .red
        imageView.layer.cornerRadius = 10
        
        // Drop Shadow on TitleLabel
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        guard tripTextField.text != "", let newTripName = tripTextField.text else {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .default)
            imageView.image = UIImage(systemName: "exclamationmark.triangle", withConfiguration: configuration)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .red
            
            tripTextField.rightView = imageView
            tripTextField.rightViewMode = .always
            return
        }
        
        TripFunctions.createTrip(tripModel: TripModel(title: newTripName, image: imageView.image))
        
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
    
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async {
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true)
        }
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.presentPhotoPickerController()
                    
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        self.presentPhotoPickerController()
                    }
                    
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo library access is restricted and cannot be accessed.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                    
                case .denied:
                    print("Denied")
                    let alert = UIAlertController(title: "Photo Library Denied", message: "Photo library access was previosuly denied. Please update your Settings if you wish to change this.", preferredStyle: .alert)
                    let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)!
                            UIApplication.shared.open(url, options: [:])
                            
                        }
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(cancelAction)
                    alert.addAction(goToSettingsAction)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                    
                }
            }
        }
    }
    
    
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}
