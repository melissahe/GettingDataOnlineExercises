//
//  BeerListViewController.swift
//  GettingDataOnlineExercises
//
//  Created by C4Q on 11/27/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController {

    //Table View Data Source Variables
    @IBOutlet weak var beerTableView: UITableView!
    var beerList: [Beer] = []
    var sectionNames: [String] = []
    
    //Search Bar Variables
    @IBOutlet weak var searchBar: UISearchBar!
    var filteringIsOn: Bool = false
    var searchTerm: String = "" {
        didSet {
            if searchTerm == "" {
                filteringIsOn = false
            } else {
                searchTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
            }
            
            loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        getSectionNames()
        beerTableView.delegate = self
        beerTableView.dataSource = self
        searchBar.delegate = self
    }
    
    func loadData() {
        let urlStr = (filteringIsOn) ? "https://api.punkapi.com/v2/beers/?beer_name=\(searchTerm)" : "https://api.punkapi.com/v2/beers"
            
        BeerAPIClient.manager.getBeers(
            from: urlStr,
            completionHandler: {(onlineBeerArray) in
                self.beerList = onlineBeerArray.sorted{$0.abv < $1.abv}
                if !self.filteringIsOn {
                    self.getSectionNames()
                }
                DispatchQueue.main.async {
                    self.beerTableView.reloadData()
                }
        },
            errorHandler: {print($0)})
    }
    
    func getSectionNames() {
        for beer in beerList {
            if !sectionNames.contains(beer.sectionName) {
                sectionNames.append(beer.sectionName)
            }
        }
    }
    
    func getBeersInSection(section: Int) -> [Beer] {
        return beerList.filter{$0.sectionName == sectionNames[section]}
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let cell = sender as? UITableViewCell,
            let selectedIndexPath = beerTableView.indexPath(for: cell),
            let destinationVC = segue.destination as? BeerDetailViewController {
            let beersInSection = getBeersInSection(section: selectedIndexPath.section)
            let selectedBeer = (filteringIsOn) ? beerList[selectedIndexPath.row] : beersInSection[selectedIndexPath.row]
            //to do
         }
    }
}

//Table View Methods
extension BeerListViewController: UITableViewDelegate, UITableViewDataSource {
    //Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if beerList.isEmpty {
            return
        }
        
        let beersInSection = getBeersInSection(section: indexPath.section)
        
        let selectedCell = (filteringIsOn) ? beerList[indexPath.row] : beersInSection[indexPath.row]
        
        performSegue(withIdentifier: "detailedSegue", sender: selectedCell)
    }
    
    //Table View Data Source Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return (filteringIsOn) ? 1 : (sectionNames.count)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (filteringIsOn) ? nil : (sectionNames[section])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if beerList.isEmpty {
            return 1
        }
        
        let beersInSection = getBeersInSection(section: section)
        
        let currentRowCount = (filteringIsOn) ? (beerList.count) : (beersInSection.count)
        
        return currentRowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath)
        let beersInSection = getBeersInSection(section: indexPath.section)

        if beerList.isEmpty {
            cell.textLabel?.text = "No Results"
            cell.detailTextLabel?.text = ""
            
            return cell
        }
        
        let selectedBeer = (filteringIsOn) ? beerList[indexPath.row] : beersInSection[indexPath.row]
        
        cell.textLabel?.text = selectedBeer.name
        cell.detailTextLabel?.text = selectedBeer.tagline
        
        return cell
    }
}

extension BeerListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        
        filteringIsOn = true
        
        searchTerm = searchText
        searchBar.resignFirstResponder()
    }
}
