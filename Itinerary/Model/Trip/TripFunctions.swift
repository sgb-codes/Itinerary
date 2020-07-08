//
//  TripFunctions.swift
//  Itinerary
//
//  Created by Simon Barrett on 06/07/2020.
//  Copyright © 2020 Simon Barrett. All rights reserved.
//

import UIKit

class TripFunctions {
    // Create a New Trip and Add to the Data Model
    static func createTrip(tripModel: TripModel) {
        Data.tripModels.append(tripModel)
    }
    
    // Read Trips from Database and Populate tripModels
    static func readTrip(completion: @escaping () -> ()) {
        // Load trips on background thread
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.tripModels.count == 0 {
                Data.tripModels = MockData.createMockTripModelData()
            }
        }
        // Go back to main thread
        DispatchQueue.main.async {
            completion()
        }
    }
    
    // Read Trip by ID from Database and Populate TripModel
    static func readTrip(by id: String, completion: @escaping (TripModel?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            // Returns the first element of the array which contains the unique ID
            let trip = Data.tripModels.first(where: { $0.id == id })
            
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    // Update trip models after editing
    static func updateTrip(at index: Int, title: String, image: UIImage? = nil) {
        Data.tripModels[index].title = title
        Data.tripModels[index].image = image
    }
    
    // Delete trip model
    static func deleteTrip(index: Int) {
        Data.tripModels.remove(at: index)
    }
}
