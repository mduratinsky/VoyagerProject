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
    private var mName: String
    private var mPhoto: UIImage
    
    //Optional attributes
    private var mListOfTours: [Tour]?
    
    init(name: String, image: UIImage) {
        mName = name
        mPhoto = image
    }
    
    func getName() -> String {
        return mName
    }
    
    func setName(name: String) {
        mName = name
    }
    
    func getPhoto() -> UIImage {
        return mPhoto
    }
    
    func setPhoto(image: UIImage) {
        mPhoto = image
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