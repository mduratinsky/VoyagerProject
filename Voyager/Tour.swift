//
//  Tour.swift
//  Voyager
//
//  Created by Brett Oberg on 11/2/15.
//  Copyright © 2015 Voyager. All rights reserved.
//

import Foundation

class Tour {
    //Mandatory attributes
    var id: String? //Object ID within Parse
    var userId: String?
    var mName: String
    var mListOfLocations: [Location]
    var mCategory: String
    var mAuthor: String
    var views = 0 //number of times the tour has been viewed
    var starts = 0 //number of times the tour has been taken
    var completes = 0 //number of times the tour has been completed
    //Optional attributes
    var mDescription: String?
    var mComments: [String]?
    var mRating: Int?
    
    init(name: String, locations: [Location], category: String, author: String) {
        mName = name
        mListOfLocations = locations
        mCategory = category
        mAuthor = author
    }
    
    func getName() -> String {
        return mName
    }
    
    func setName(name: String) {
        mName = name
    }
    
    func getListOfLocations() -> [Location] {
        return mListOfLocations
    }
    
    func setListOfLocations(locations: [Location]) {
        mListOfLocations = locations
    }
    
    func addLocation(location: Location) {
        mListOfLocations.append(location)
    }
    
    func removeLocation(location: Location) {
        // TODO
    }
    
    func getCategory() -> String {
        return mCategory
    }
    
    func setCategory(category: String) {
        mCategory = category
    }
    
    func getAuthor() -> String {
        return mAuthor
    }
    
    func setAuthor(author: String) {
        mAuthor = author
    }
    
    func getDescription() -> String {
        return mDescription!
    }
    
    func setDescription(description: String) {
        mDescription = description
    }
    
    func getComments() -> [String] {
        return mComments!
    }
    
    func setComments(comments: [String]) {
        mComments = comments
    }
    
    func addComment(comment: String) {
        mComments?.append(comment)
    }
    
    func removeComment(comment: String) {
        // TODO
    }
    
    func getRating() -> Int {
        return mRating!
    }
    
    func addNewRating(rating: Int) {
        //TODO
    }
}
