//
//  StoresViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 6/4/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class StoresViewController : UITableViewController {
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let resourceGetService = ResourceGetService()
    fileprivate var stores = [String]()
    fileprivate var filteredStores = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resourceGetService.getAllStores() { response in
            self.stores = response
            self.tableView.reloadData()
        }
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
    }
}

extension StoresViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredStores = stores.filter { store in
            return store.lowercased().contains(searchText.lowercased())
        }
        
        self.tableView.reloadData()
    }
}

extension StoresViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storeCell = UITableViewCell.init(style: .default, reuseIdentifier: "StoreCell")
        let searchCell = self.tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
            
        if (searchController.isActive && searchController.searchBar.text != "") {
            if (indexPath.row == 0) {
                searchCell.searchTextLabel?.text = self.searchController.searchBar.text
                return searchCell
            } else {
                storeCell.textLabel?.text = self.filteredStores[indexPath.row - 1]
                return storeCell
            }
        } else {
            storeCell.textLabel?.text = self.stores[indexPath.row]
            return storeCell
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != "") {
            return filteredStores.count + 1
        } else {
            return self.stores.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var place : String?
        
        if (searchController.isActive && searchController.searchBar.text != "") {
            if (indexPath.row == 0) {
                place = self.searchController.searchBar.text
            } else {
                place = self.filteredStores[indexPath.row - 1]
            }
        } else {
            place = self.stores[indexPath.row]
        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsViewController
        rewardsVC.placeName = place
        self.navigationController?.pushViewController(rewardsVC, animated: true)
    }
}
