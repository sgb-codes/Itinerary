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
    @IBOutlet weak var tripImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        cardView.addShadowAndRoundedCorners()
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 32)
        cardView.backgroundColor = Theme.accent
        tripImageView.layer.cornerRadius = cardView.layer.cornerRadius
        
    }
    
    func setup(tripModel: TripModel) {
        titleLabel.text = tripModel.title
        tripImageView.image = tripModel.image
    }
    
}
