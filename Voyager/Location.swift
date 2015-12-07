//
//  Location.swift
//  Voyager
//
//  Created by Brett Oberg on 11/2/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation

class Location {
    //Mandatory attributes
    var mName: String
    var mLongitude: Double
    var mLatitude: Double
    
    //Optional attributes
    
    init(name: String, longitude: Double, latitude: Double) {
        mName = name
        mLongitude = longitude
        mLatitude = latitude
    }

    func getName() -> String {
        return mName
    }
    
    func setName(name: String) {
        mName = name
    }
    
    func getLongitude() -> Double {
        return mLongitude
    }
    
    func setLongitude(longitude: Double) {
        mLongitude = longitude
    }
    
    func getLatitude() -> Double {
        return mLatitude
    }
    
    func setLatitude(latitude: Double) {
        mLatitude = latitude
    }
}