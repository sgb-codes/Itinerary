//
//  AddActivityViewController.swift
//  Itinerary
//
//  Created by Simon Barrett on 09/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    //MARK: - Global Variables and IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dayPickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    var tripIndex: Int!
    var tripModel: TripModel!
    var doneSaving: ((Int, ActivityModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        dayPickerView.dataSource = self
        dayPickerView.delegate = self
        
        //MARK: - Additional UI Setup
        
        // Setup: Title Label, Camera Colour, ViewController Corners
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 26)

    }
    
    // Called when User presses Cancel Button
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    // Called when User presses Save Button
    @IBAction func save(_ sender: UIButton) {
        
        // Check Textfield is not nil and assign text to variable
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        
        let activityType: ActivityType = getSelectedActivityType()
        let dayIndex = dayPickerView.selectedRow(inComponent: 0)
        let activityModel = ActivityModel(title: newTitle, subTitle: subtitleTextField.text ?? "", activityType: activityType)
        
        ActivityFunctions.createActivity(at: tripIndex, for: dayIndex, using: activityModel)
        
        if let doneSaving = doneSaving {
            doneSaving(dayIndex, activityModel)
        }
        dismiss(animated: true)
    }
    
    // Called when User presses one of the Icons
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        
        // Sets all Buttons to Unselected Colour
        activityTypeButtons.forEach( { $0.tintColor = Theme.accent})
        
        // Sets selected button colour to Tint Colour
        sender.tintColor = Theme.tint
    }
    
    
    func getSelectedActivityType() -> ActivityType {
        for (index, button) in activityTypeButtons.enumerated() {
            if button.tintColor == Theme.tint {
                return ActivityType(rawValue: index) ?? .excursion
            }
        }
        return .excursion
    }
}

extension AddActivityViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripModel.dayModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tripModel.dayModels[row].title.mediumDate()
    }
}
