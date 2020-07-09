//
//  UITextFieldExtension.swift
//  Itinerary
//
//  Created by Simon Barrett on 09/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

extension UITextField {
    // Check that the TextField has Writing in it
    var hasValue: Bool {
        guard text == "" else { return true }
        
        // If text field is nil, add a warning sign to right side of textfield
        // Create UIView to present image in
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        // Configure SFSymbol and Add it to Image View
        let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .default)
        imageView.image = UIImage(systemName: "exclamationmark.triangle", withConfiguration: configuration)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .red
        
        // Add ImageView with Image to Text Field
        rightView = imageView
        // If User has typed a letter then warning sign will disappear
        rightViewMode = .unlessEditing
        
        return false

    }
}
