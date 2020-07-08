//
//  PopupButton.swift
//  Itinerary
//
//  Created by Simon Barrett on 07/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class PopupButton: UIButton {

    // Styling for Buttons on AddTrip Popup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Background Colour, Font Colour, Rounded Corners
        backgroundColor = Theme.tint
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = frame.height / 2
    }
}
