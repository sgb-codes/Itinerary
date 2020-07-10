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
    
    // Delete Activity and Remove from the Data Model
    static func deleteActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        
        if let index = Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.firstIndex(of: activityModel) {
            Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.remove(at: index)
        }
    }
    
    // Update Activity when editing Cell
    static func updateActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, using activityModel: ActivityModel) {
        
        // Move Activity to a different day
        if oldDayIndex != newDayIndex {
            let lastIndex = Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.count
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex, activityModel: activityModel)
            
        } else {
            
            // Update activity in same day
            let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
            let activityIndex = (dayModel.activityModels.firstIndex(of: activityModel))!
            Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels[activityIndex] = activityModel
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, activityModel: ActivityModel) {
        
        // 1. Remove activity from old location
        let oldDayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
        let oldActivityIndex = (oldDayModel.activityModels.firstIndex(of: activityModel))!
        Data.tripModels[tripIndex].dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
        
        // 2. Inset activity into new location
        Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.insert(activityModel, at: newActivityIndex)
    }

}
