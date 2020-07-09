//
//  AddDayViewController.swift
//  Itinerary
//
//  Created by Simon Barrett on 09/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {
    
    //MARK: - Global Variables and IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: (() -> ())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Additional UI Setup
        
        // Setup: Title Label
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 26)

        
//        // When Edit button Tapped, change ViewController Title and Load Trip details into ViewController
//        if let index = tripIndexToEdit {
//            let trip = Data.tripModels[index]
//            titleLabel.text = "Edit Trip"
//            titleTextField.text = trip.title
//        }
    }
    
    // Called when User presses Cancel Button
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
        
    }
    
    // Called when User presses Save Button
    @IBAction func save(_ sender: UIButton) {
        
        // Check Textfield is not nil and assign text to variable
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        
//        // If Editing Trip then update TripModel
//        if let index = tripIndexToEdit {
//            TripFunctions.updateTrip(at: index, title: newTripName, image: imageView.image)
//        }
//        // If adding a new trip then Create new trip in TripModel
//        else {
//        TripFunctions.createTrip(tripModel: TripModel(title: newTripName, image: imageView.image))
//        }
        
        // Check Data Saved and Dismiss ViewController
        if let doneSaving = doneSaving {
            doneSaving()
        }
        dismiss(animated: true)
    }
}
