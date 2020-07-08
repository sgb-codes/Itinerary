//
//  ActivityModel.swift
//  Itinerary
//
//  Created by Simon Barrett on 08/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation
import UIKit

// Struct to hold Activity Information, Unique ID to be used to fetch from database
struct ActivityModel {
    var id: String!
    var title = ""
    var subTitle = ""
    var activityType: ActivityType
    var photo: UIImage?
    
    init(title: String, subTitle: String, activityType: ActivityType, photo: UIImage? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        self.activityType = activityType
        self.photo = photo
    }
    
}
