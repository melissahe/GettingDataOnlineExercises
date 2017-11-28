//
//  Currency.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class Currency {
    let base: String
    let rates: [String : Any]

    init(base: String, rates: [String : Any]) {
        self.base = base
        self.rates = rates
    }
    
    convenience init?(from currencyDict: [String : Any]) {
        guard let base = currencyDict["base"] as? String else {
            print("base didn't work")
            return nil
        }
        
        guard let rates = currencyDict["rates"] as? [String : Any] else {
            print("rates didn't work")
            return nil
        }
        
        self.init(base: base, rates: rates)
    }
}
