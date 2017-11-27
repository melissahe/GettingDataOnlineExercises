//
//  BeerAPIClient.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class BeerAPIClient {
    private init() {}
    static let manager = BeerAPIClient()
    func getBeers(from urlString: String, completionHandler: @escaping ([Beer]) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            print("url didn't work")
            return
        }
        
        NetworkHelper.manager.performDataTask(
            from: url,
            completionHandler: { (data: Data) in
                var beerArray: [Beer] = []
                do {
                    guard let beerDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                        print("json didn't work")
                        return
                    }
                    
                    for beerDict in beerDictArray {
                        if let beer = Beer(from: beerDict) {
                            beerArray.append(beer)
                        }
                    }
                    
                    completionHandler(beerArray)
                    
                } catch let error{
                    print(error)
                    errorHandler(error)
                }
        },
            errorHandler: errorHandler)
        
    }
}
