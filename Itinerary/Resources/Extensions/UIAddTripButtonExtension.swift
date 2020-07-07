//
//  UIButtonExtension.swift
//  Itinerary
//
//  Created by Simon Barrett on 07/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

extension UIButton {
    func createFloatingActionButton() {
        
        // Plus Image
        let Config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .default)
        let addButton = UIImage(systemName: "plus", withConfiguration: Config)
        setImage(addButton, for: .normal)
        tintColor = .white

        // Frame and Background
        backgroundColor = Theme.tint
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
