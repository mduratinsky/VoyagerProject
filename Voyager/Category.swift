//
//  Category.swift
//  Voyager
//
//  Created by Brett Oberg on 11/2/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation

class Category {
    //Mandatory attributes
    var mName: String
    
    //Optional attributes
    var mListOfTours: [Tour]?
    
    init(name: String) {
        mName = name
    }
    
    func getName() -> String {
        return mName
    }
    
    func setName(name: String) {
        mName = name
    }
    
    func getTours() -> [Tour] {
        return mListOfTours!
    }
    
    func setTours(tours: [Tour]) {
        mListOfTours = tours
    }
    
    func addNewTour(tour: Tour) {
        mListOfTours?.append(tour)
    }
    
    func removeTour(tour: Tour) {
        //TODO
    }
}