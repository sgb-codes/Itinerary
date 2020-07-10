//
//  DayFunctions.swift
//  Itinerary
//
//  Created by Simon Barrett on 09/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation

class DayFunctions {
    // Create a New Day and Add to the Data Model
    static func createDay(at tripIndex: Int, using dayModel: DayModel) {
        Data.tripModels[tripIndex].dayModels.append(dayModel)
    }
}
