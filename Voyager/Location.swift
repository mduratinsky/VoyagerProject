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
    //var image: UIImage? = UIImage(named: "placeholder_scene.jpg")
    //Optional attributes
    
    init(name: String, longitude: Double, latitude: Double, des: String, tourId: String, ind: Int) {
        mName = name
        mLongitude = longitude
        mLatitude = latitude
        mDescription = des
        mTourId = tourId
        mIndex = ind
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
    
    func getDescription() -> String {
        return mDescription
    }
    
    func setDescription(des: String) {
        mDescription = des
    }
    
    func getTourId() -> String {
        return mTourId
    }
    
    func setTourId(str: String) {
        mTourId = str
    }
    
    func getIndex() -> Int {
        return mIndex
    }
    
    func setIndex(ind: Int) {
        mIndex = ind
    }
    
}