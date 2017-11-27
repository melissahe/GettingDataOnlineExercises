//
//  Beer.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class Beer {
    let name: String
    let tagline: String
    let description: String
    let imageURL: String
    let abv: Double
    
    var sectionName: String {
        let roundedDownAbv = Int(abv)
        return "\(roundedDownAbv).0 - \(roundedDownAbv).9%"
    }
    
    init(name: String, tagline: String, description: String, imageURL: String, abv: Double) {
        self.name = name
        self.tagline = tagline
        self.description = description
        self.imageURL = imageURL
        self.abv = abv
    }
    
    convenience init?(from beerDict: [String : Any]) {
        guard let name = beerDict["name"] as? String else {
            print("Name didn't work")
            return nil
        }
        
        guard let tagline = beerDict["tagline"] as? String else {
            print("Tagline didn't work")
            return nil
        }
        
        guard let description = beerDict["description"] as? String else {
            print("Description didn't work")
            return nil
        }
        
        guard let imageURL = beerDict["image_url"] as? String else {
            print("image url didn't work")
            return nil
        }
        
        guard let abv = beerDict["abv"] as? Double else {
            print("abv didn't work")
            return nil
        }
        
        self.init(name: name, tagline: tagline, description: description, imageURL: imageURL, abv: abv)
        
    }
    
}
