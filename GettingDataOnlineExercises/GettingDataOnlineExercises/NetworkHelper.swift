//
//  NetworkHelper.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let urlSession = URLSession(configuration: .default)
    func performDataTask(from url: URL, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.main.async {
            let request = URLRequest(url: url)
            self.urlSession.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    return
                }
                
                if let error = error {
                    errorHandler(error)
                }
                
                completionHandler(data)
                }.resume()
        }
    }
}
