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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: ((DayModel) -> ())?
    var tripIndex: Int!
    var tripModel: TripModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Additional UI Setup
        
        // Setup: Title Label
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 26)
        
        self.hideKeyboardWhenTappedAround()
        
        
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
        
        // Check Date does not already exist
        if alreadyExists(datePicker.date) {
            
            // If date already exists show Alert
            let alert = UIAlertController(title: "Day Already Exists", message: "Choose Another Date", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        
        
        // Add Day to the Database
        let dayModel = DayModel(title: datePicker.date, subtitle: subtitleTextField.text ?? "", data: nil)
        DayFunctions.createDays(at: tripIndex, using: dayModel)
        
        
        // Check Data Saved and Dismiss ViewController
        if let doneSaving = doneSaving {
            doneSaving(dayModel)
        }
        dismiss(animated: true)
    }
    
    // Text Field Exits when Done button is pressed
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func alreadyExists(_ date: Date) -> Bool {        
        if tripModel.dayModels.contains(where: { $0.title.mediumDate() == date.mediumDate() }) {
            return true
        }
        return false
    }
}
