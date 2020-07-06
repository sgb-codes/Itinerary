//
//  TripModel.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation

class TripModel {
    var id: String!
    var title: String!
    
    init(title: String) {
        id = UUID().uuidString
        self.title = title
    }
}
