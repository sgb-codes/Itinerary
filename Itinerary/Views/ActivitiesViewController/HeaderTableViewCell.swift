//
//  HeaderTableViewCell.swift
//  Itinerary
//
//  Created by Simon Barrett on 08/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    //MARK: - Global Variables and IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Style Cell
        titleLabel.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 15)
    }
    
    // Setup Data for Cell
    func setup(model: DayModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}
