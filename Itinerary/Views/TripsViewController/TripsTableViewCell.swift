//
//  TripsTableViewCell.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {

    //MARK: - Global Varaibles and IBOutlets
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Style Table View Cell
        cardView.addShadowAndRoundedCorners()
        
        // Change Font and Background Colour
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 32)
        cardView.backgroundColor = Theme.accent
        
        // If an Image has been added then round the corners of the image
        tripImageView.layer.cornerRadius = cardView.layer.cornerRadius
        
    }
    
    // Add Data to tableViewCell
    func setup(tripModel: TripModel) {
        titleLabel.text = tripModel.title
        
        // Create animation when adding Image to Cell
        if let tripImage = tripModel.image {
            tripImageView.alpha = 0.3
            tripImageView.image = tripImage
            
            UIView.animate(withDuration: 1) {
                self.tripImageView.alpha = 1
            }
        }

    }
    
}
