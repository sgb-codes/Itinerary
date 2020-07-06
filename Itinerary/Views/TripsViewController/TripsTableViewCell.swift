//
//  TripsTableViewCell.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        cardView.addShadowAndRoundedCorners()
    }
    
    func setup(tripModel: TripModel) {
        titleLabel.text = tripModel.title
    }
    
}
