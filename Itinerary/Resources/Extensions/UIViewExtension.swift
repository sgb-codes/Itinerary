//
//  UIViewExtensions.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

extension UIView {
     // Styling for TripsViewController Cells
    func addShadowAndRoundedCorners() {
       
        // Create Drop Shadow
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        
        // Rounded Corners
        layer.cornerRadius = 10
    }
}
