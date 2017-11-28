//
//  BeerDetailViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameLabel.text = beer.name
        abvLabel.text = beer.abv.description + "%"
        descriptionTextView.text = beer.description
        setupImages()
    }
    
    func setupImages() {
        guard let url = URL(string: beer.imageURL) else {
            return
        }
        
        NetworkHelper.manager.performDataTask(
            from: url,
            completionHandler: { (data) in
                guard let image = UIImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.beerImageView.image = image
                }
        },
            errorHandler: {print($0)})
    }
}
