//
//  ActivityFunctions.swift
//  Itinerary
//
//  Created by Simon Barrett on 09/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation

class ActivityFunctions {
    
    // Create a New Activity and Add to the Data Model
    static func createActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.append(activityModel)
    }
}
