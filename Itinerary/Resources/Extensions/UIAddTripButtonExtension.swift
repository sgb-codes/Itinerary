//
//  UIButtonExtension.swift
//  Itinerary
//
//  Created by Simon Barrett on 07/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

extension UIButton {
    // Styling and Button Symbol for Floating Action Button on TripsViewController
    func createFloatingActionButton() {
        
        // Style and Add the Plus Symbol to the button
        let Config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .default)
        let addButton = UIImage(systemName: "plus", withConfiguration: Config)
        setImage(addButton, for: .normal)
        tintColor = .white

        // Background sytling: Change the Background colour, Add Drop Shadow and Make it Circular
        backgroundColor = Theme.tint
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
