//
//  StudioGhibliDetailViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class StudioGhibliDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var producerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var studioGhibliFilm: StudioGhibliFilm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = studioGhibliFilm.title
        directorLabel.text = studioGhibliFilm.director
        producerLabel.text = studioGhibliFilm.producer
        releaseDateLabel.text = studioGhibliFilm.releaseDate
        summaryTextView.text = studioGhibliFilm.description
    }
    
}
