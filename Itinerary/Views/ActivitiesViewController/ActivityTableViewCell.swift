//
//  ActivityTableViewCell.swift
//  Itinerary
//
//  Created by Simon Barrett on 08/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    //MARK: - Global Variables and IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var activityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style Cell
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
    }
    
    // Setup Data for Cell
    func setup(model: ActivityModel) {
        activityImageView.image = getActivityImageView(type: model.activityType)
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
    }

    // Switch to Decide what Image to show
    func getActivityImageView(type: ActivityType) -> UIImage {
        switch type {
        case .auto:
            return UIImage(named: "Car")!
        case .excursion:
            return UIImage(named: "Excursion")!
        case .flight:
            return UIImage(named: "Plane")!
        case .food:
            return UIImage(named: "Food")!
        case .hotel:
            return UIImage(named: "Hotel")!
        }
    }
}
