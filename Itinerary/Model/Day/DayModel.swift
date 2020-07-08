//
//  DayModel.swift
//  Itinerary
//
//  Created by Simon Barrett on 08/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation

// Struct to hold Day Information, Unique ID to be used to fetch from database
struct DayModel {
    var id: String!
    var title = ""
    var subtitle = ""
    var activityModels = [ActivityModel]()
    
    init(title: String, subtitle: String, data: [ActivityModel]?) {
        id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        
        if let data = data {
            self.activityModels = data
        }
    }
}
