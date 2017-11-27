//
//  StudioGhibliAPIClient.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class StudioGhibliAPIClient {
    private init() {}
    static let manager = StudioGhibliAPIClient()
    func getMovies(from urlString: String,
                   completionHandler: @escaping ([StudioGhibliFilm]) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Could not get url")
            return
        }
        
        NetworkHelper.manager.performDataTask(
            from: url,
            completionHandler: { (data: Data) in
                var studioGhibliFilmArray: [StudioGhibliFilm] = []
                do {
                    guard let ghibliFilmDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                        print("Could not convert json object")
                        return
                    }
                    
                    for dict in ghibliFilmDictArray {
                        if let studioGhibliFilm = StudioGhibliFilm(from: dict) {
                            studioGhibliFilmArray.append(studioGhibliFilm)
                        }
                    }
                    
                    completionHandler(studioGhibliFilmArray)
                } catch let error {
                    print(error)
                    errorHandler(error)
                }
        },
            errorHandler: errorHandler)
    }
}
