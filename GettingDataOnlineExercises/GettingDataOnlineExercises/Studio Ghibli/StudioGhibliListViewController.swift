//
//  StudioGhibliListViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class StudioGhibliListViewController: UIViewController {

    @IBOutlet weak var filmTableView: UITableView!
   
    var studioGhibliFilms: [StudioGhibliFilm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        filmTableView.delegate = self
        filmTableView.dataSource = self
    }

    func loadData() {
        let urlStr = "https://ghibliapi.herokuapp.com/films"
        
        StudioGhibliAPIClient.manager.getMovies(
            from: urlStr,
            completionHandler: { (studioGhibliFilmArray: [StudioGhibliFilm]) in
                self.studioGhibliFilms = studioGhibliFilmArray
                
                DispatchQueue.main.async {
                    self.filmTableView.reloadData()
                }
        },
            errorHandler: {print($0)})
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UITableViewCell,
            let selectedIndexPath = filmTableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? StudioGhibliDetailViewController {
            
            let selectedFilm = studioGhibliFilms[selectedIndexPath.row]
            destinationVC.studioGhibliFilm = selectedFilm
        }
    }
    
}

//Table View Methods
extension StudioGhibliListViewController: UITableViewDelegate, UITableViewDataSource {
    //Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedSegue", sender: tableView.cellForRow(at: tableView.indexPathForSelectedRow!))
    }
    
    //Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studioGhibliFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)
        let currentFilm = studioGhibliFilms[indexPath.row]
        
        cell.textLabel?.text = currentFilm.title
        cell.detailTextLabel?.text = currentFilm.releaseDate
        
        return cell
    }
}
