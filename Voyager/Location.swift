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
    var mLongitude: Int
    var mLatitude: Int
    
    //Optional attributes
    
    init(name: String, longitude: Int, latitude: Int) {
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
    
    func getLongitude() -> Int {
        return mLongitude
    }
    
    func setLongitude(longitude: Int) {
        mLongitude = longitude
    }
    
    func getLatitude() -> Int {
        return mLatitude
    }
    
    func setLatitude(latitude: Int) {
        mLatitude = latitude
    }
}