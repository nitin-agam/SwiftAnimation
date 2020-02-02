//
//  UserDefault+Extension.swift
//  NAExtensions
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation
import CoreLocation

public struct UserDefaultKeys {
    static let kLatitude = "latitude"
    static let kLongitude = "longitude"
}

public extension UserDefaults {
    
    // to save location of the user
    func saveLocation(location: CLLocation) {
        self.set("\(location.coordinate.latitude)", forKey: UserDefaultKeys.kLatitude)
        self.set("\(location.coordinate.longitude)", forKey: UserDefaultKeys.kLongitude)
        self.synchronize()
    }
    
    // to fetch the location of the user
    func getLocation() -> (latitude: String, longitude: String)? {
        if let lat = self.value(forKey: UserDefaultKeys.kLatitude) as? String, let long = self.value(forKey: UserDefaultKeys.kLongitude) as? String {
            return (lat, long)
        }
        return nil
    }
}
