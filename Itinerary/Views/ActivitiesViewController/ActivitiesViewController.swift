//
//  ActivitiesViewController.swift
//  Itinerary
//
//  Created by Simon Barrett on 08/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    //MARK: - Global Variables and IBOutlets
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: PopupButton!
    
    var tripId: UUID!
    var tripTitle: String = ""
    var tripModel: TripModel?
    var sectionHeaderHeight: CGFloat = 0.0

    fileprivate func updateTableViewWithTripData() {
        // Load Trip from Unique ID
        TripFunctions.readTrip(by: tripId) { [weak self] (model) in
            // Check that User has remainded on page after data has loaded
            guard let self = self else { return }
            self.tripModel = model
            // Check there is data in the TripModel
            guard let model = model else { return }
            // Load Data into ViewController
            self.backgroundImageView.image = model.image
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Title
        title = tripTitle
        
        // Attach TableView to ViewController
        tableView.dataSource = self
        tableView.delegate = self
       
        // Stlye Floating Add Button
        addButton.createFloatingActionButton()

        updateTableViewWithTripData()
        
        // Set Height of Section Header Cell
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: Constants.headerCell)?.contentView.bounds.height ?? 0
    }
    
    // Create Action sheet to let user Add Days or Activities
    @IBAction func addAction(_ sender: PopupButton) {
        
        // Create Action Sheet
        let alert = UIAlertController(title: "What would you like to add?", message: nil, preferredStyle: .actionSheet)
        
        // Create Day, Activity and Cancel Buttons for Action Sheet
        let dayAction = UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
        let activityAction = UIAlertAction(title: "Activity", style: .default, handler: handleAddActivity)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Disable add Activity Action if there are no days added to the trip
            activityAction.isEnabled = tripModel!.dayModels.count > 0
        
        // Add Buttons to ActionSheet
        alert.addAction(dayAction)
        alert.addAction(activityAction)
        alert.addAction(cancelAction)
        
        // Allow AlertSheet to work on Ipad
        alert.popoverPresentationController?.sourceView = addButton
        
        // Change Action Sheet title Colours
        alert.view.tintColor = Theme.edit
        
        // Present Action Sheet to User
        present(alert, animated: true)
    }
    
    
    fileprivate func getTripIndex() -> Array<TripModel>.Index! {
        return Data.tripModels.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == tripId
        })
    }
    
    // Called when user clicks on Day in action sheet
    func handleAddDay(action: UIAlertAction) {
        
        // Segue to AddDayViewController
        let vc = AddDayViewController.getInstance() as! AddDayViewController
        
        // AddDayViewController can access the data in our model
        vc.tripModel = tripModel
        
        // Get reference to Trip which will be shown
        vc.tripIndex = getTripIndex()
        vc.doneSaving = { [weak self] dayModel in
            guard let self = self else { return }
            self.tripModel?.dayModels.append(dayModel)
            let indexArray = [self.tripModel?.dayModels.firstIndex(of: dayModel) ?? 0 ]

            self.tableView.insertSections(IndexSet(indexArray), with: UITableView.RowAnimation.automatic)
        }

        present(vc, animated: true)
    }
    
    // Called when user clicks on Activity in action sheet
    func handleAddActivity(action: UIAlertAction) {
        
        // Segue to AddDayViewController
        let vc = AddActivityViewController.getInstance() as! AddActivityViewController
        vc.tripModel = tripModel
        vc.tripIndex = getTripIndex()
        vc.doneSaving = { [weak self] dayIndex, activityModel in
            guard let self = self else { return }
            self.tripModel?.dayModels[dayIndex].activityModels.append(activityModel)
            let row = (self.tripModel?.dayModels[dayIndex].activityModels.count)! - 1
            let indexPath = IndexPath(row: row, section: dayIndex)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
        }

        
        present(vc, animated: true)
    }
    
    
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of Sections in table equal to Amount of dayModels in Array
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    // Set Section Header to be of Type HeaderViewCell
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = tripModel?.dayModels[section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.headerCell) as! HeaderTableViewCell
        cell.setup(model: dayModel!)
        
        return cell.contentView
    }
    
    // Set Height of Section Header Cell
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return sectionHeaderHeight
    }

    // Set Number of Rows Per Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activityModels.count ?? 0
    }
    
    // Set Data for Each TableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        
        cell.setup(model: model!)
        return cell
    }
    
    //MARK: - Add Swipe Functions to Cell UI
    
    // Add Delete Swipe function to Cell when swiped left
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let activityModel = tripModel!.dayModels[indexPath.section].activityModels[indexPath.row]
                
        // Add Delete button to right hand side of Cell
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            // If users presses Delete create Alert to Confirm User Decision
            let alert = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete this activity?", preferredStyle: .alert)
            // Create Cancel Button for Alert
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            // Create Delete Button For Alert
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                
                // Delete Activity from Database and Delete Cell
                ActivityFunctions.deleteActivity(at: self.getTripIndex(), for: indexPath.section, using: activityModel)
                self.tripModel!.dayModels[indexPath.section].activityModels.remove(at: indexPath.row)
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
    
    // Add Edit Swipe function to cell when swiped left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let vc = AddActivityViewController.getInstance() as! AddActivityViewController
            vc.tripModel = self.tripModel
            
            // Which Trip are we working with?
            vc.tripIndex = self.getTripIndex()
            
            // Which Day are we on?
            vc.dayIndexToEdit = indexPath.section
            
            // Which Activity are we editing?
            vc.activityModelToEdit = self.tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
            
            // What do we want to happen after the Activity is saved?
            vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
                guard let self = self else { return }
                
                let oldActivityIndex = (self.tripModel?.dayModels[oldDayIndex].activityModels.firstIndex(of: activityModel))!
                
                if oldDayIndex == newDayIndex {
                    // 1. Update the local table data
                    self.tripModel?.dayModels[newDayIndex].activityModels[oldActivityIndex] = activityModel
                    // 2. Refresh just that Row
                    let indexPath = IndexPath(row: oldActivityIndex, section: newDayIndex)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    // Activity Moved to a different day
                    
                    // 1. Remove activity from local table data
                    self.tripModel?.dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
                    // 2. Insert activity into new location
                    let lastIndex = (self.tripModel?.dayModels[newDayIndex].activityModels.count)!
                    self.tripModel?.dayModels[newDayIndex].activityModels.insert(activityModel, at: lastIndex)
                    // 3. Update table rows
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .automatic)
                    })
                }
            }
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        // Add image to Edit Button and Change Background Colour
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = Theme.edit
        
         return UISwipeActionsConfiguration(actions: [edit])
    }
}
