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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Navigation Bar Title
        title = tripTitle
        
        // Attach TableView to ViewController
        tableView.dataSource = self
        tableView.delegate = self
       
        // Stlye Floating Add Button
        addButton.createFloatingActionButton()

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
        
        // Set Height of Section Header Cell
        sectionHeaderHeight = tableView.dequeueReusableCell(withIdentifier: Constants.headerCell)?.contentView.bounds.height ?? 0
    }
    
    @IBAction func addAction(_ sender: PopupButton) {
        
        let alert = UIAlertController(title: "What would you like to add?", message: nil, preferredStyle: .actionSheet)
        let dayAction = UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
        let activityAction = UIAlertAction(title: "Activity", style: .default) { (UIAlertAction) in
                print("Add Activity")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(dayAction)
        alert.addAction(activityAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = Theme.edit
        
        present(alert, animated: true)
    }
    
    func handleAddDay(action: UIAlertAction) {
        print("Add new Day")
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
        var model = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        
        cell.setup(model: model!)
        return cell
    }
}
