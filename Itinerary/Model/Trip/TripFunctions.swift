//
//  TripFunctions.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import Foundation

class TripFunctions {
    static func createTrip(tripModel: TripModel) {
        
    }
    
    static func readTrip() {
        if Data.tripModels.count == 0 {
            Data.tripModels.append(TripModel(title: "Trip to Bali!"))
            Data.tripModels.append(TripModel(title: "Mexico"))
            Data.tripModels.append(TripModel(title: "Russian Trip"))
        }
    }
    
    static func updateTrip(tripModel: TripModel) {
        
    }
    
    static func deleteTrip(tripModel: TripModel) {
        
    }
}
