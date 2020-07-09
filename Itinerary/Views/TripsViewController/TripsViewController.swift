//
//  TripsViewController.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController{
    
    //MARK: - Global Variables and IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set View Controller as TableView Delegate and Datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        // Load Trip Data from Database
        TripFunctions.readTrip { [unowned self] in
            self.tableView.reloadData()
            
        // Check if there is at least one row showing in ViewController
            if Data.tripModels.count >= 1 {
                // Check user has not seen Help Screen
                if UserDefaults.standard.bool(forKey: Constants.seenHelpView) == false {
                    // Show user Help Screen
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.bounds
                }
            }
        }

        // Change Background colour and Style Floating Action button
        view.backgroundColor = Theme.background
        addButton.createFloatingActionButton()
    }
    
    // User presses Floating Action Button or Edit Button and is shown AddTripViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.toAddTripSegue {
            let popup = segue.destination as! AddTripViewController
            popup.tripIndexToEdit = self.tripIndexToEdit
            popup.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
    
    // Button to Close Help Screen
    @IBAction func closeHelpView(_ sender: PopupButton) {
        // Animate Help Screen Closing by slowly fading
        UIView.animate(withDuration: 0.5, animations: {
            self.helpView.alpha = 0
        }) { (success) in
            self.helpView.removeFromSuperview()
            // Record that User has seen HelpScreen
            UserDefaults.standard.set(true, forKey: Constants.seenHelpView)
        }
    }
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Amount of Cells Shown to User
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    // Create Custom Cells and Add Data to cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell) as! TripsTableViewCell
        
        cell.setup(tripModel: Data.tripModels[indexPath.row])
        
        return cell
    }
    
    // Custom Height for Cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    // Select Cell from Table View and Segue to ActivitiesViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected cell
        let trip = Data.tripModels[indexPath.row]
        
        // Instantiate an ActivitiesViewController and segue to it using the correct UUID
        let storyboard = UIStoryboard(name: String(describing: ActivitiesViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ActivitiesViewController
        vc.tripId = trip.id
        vc.tripTitle = trip.title
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - Add Swipe Functions to Cell UI
    
    // Add Delete Swipe function to Cell when swiped left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Add Delete button to right hand side of Cell
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            // If users presses Delete create Alert to Confirm User Decision
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip?", preferredStyle: .alert)
            // Create Cancel Button for Alert
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            // Create Delete Button For Alert
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                // Delete Trip from Database and Delete Cell
                TripFunctions.deleteTrip(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            // Present Alert to User
            self.present(alert, animated: true)
        }
        
        // Add Bin Image to Delete Button
        delete.image = UIImage(systemName: "bin.xmark")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Add Edit Swipe function to Cell when swiped right
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Add edit button to left hand side of cell
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            self.tripIndexToEdit = indexPath.row
            // Present Add TripViewController customised to Edit Screen
            self.performSegue(withIdentifier: Constants.toAddTripSegue, sender: nil)
            actionPerformed(true)
        }
        
        // Add image to Edit Button and Change Background Colour
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = Theme.edit
        return UISwipeActionsConfiguration(actions: [edit])
    }
}
