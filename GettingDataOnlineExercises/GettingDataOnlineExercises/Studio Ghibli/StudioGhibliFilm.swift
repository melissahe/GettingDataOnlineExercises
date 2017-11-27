//
//  StudioGhibli.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class StudioGhibliFilm {
    let title: String
    let description: String
    let director: String
    let producer: String
    let releaseDate: String
    
    init(title: String, description: String, director: String, producer: String, releaseDate: String) {
        self.title = title
        self.description = description
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
    }
    
    convenience init?(from ghibliDict: [String : Any]) {
        guard let title = ghibliDict["title"] as? String else {
            print("Error with title")
            return nil
        }
    
        guard let description = ghibliDict["description"] as? String else {
            print("Error with description")
            return nil
        }
        
        guard let director = ghibliDict["director"] as? String else {
            print("Error with director")
            return nil
        }
        
        guard let producer = ghibliDict["producer"] as? String else {
            print("Error with producer")
            return nil
        }
        
        guard let releaseDate = ghibliDict["release_date"] as? String else {
            print("Error with release date")
            return nil
        }
    
        self.init(title: title, description: description, director: director, producer: producer, releaseDate: releaseDate)
    }
}
