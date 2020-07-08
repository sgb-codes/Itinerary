//
//  PopupUIView.swift
//  Itinerary
//
//  Created by Simon Barrett on 07/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class PopupUIView: UIView {

    // Sytling for AddTrip Popup
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Create Drop Shadow
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        
        // Rounded Corners
        layer.cornerRadius = 10
        
        //Background Colour
        backgroundColor = Theme.background
        

    }

}
