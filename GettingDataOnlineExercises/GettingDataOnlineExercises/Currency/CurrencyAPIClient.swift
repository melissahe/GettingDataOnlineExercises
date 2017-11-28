//
//  CurrencyAPIClient.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class CurrencyAPIClient {
    private init() {}
    static let manager = CurrencyAPIClient()
    func getCurrencies(from urlString: String, completionHandler: @escaping (Currency) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        NetworkHelper.manager.performDataTask(
            from: url,
            completionHandler: {(data: Data) in
                do {
                    guard let currencyDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                        print("json failed")
                        return
                    }
                    
                    guard let currency = Currency(from: currencyDict) else {
                        print("currency failed")
                        return
                    }
                    
                    completionHandler(currency)
                    
                } catch let error {
                    print(error)
                    errorHandler(error)
                }
        },
            errorHandler: errorHandler)
    }
}
