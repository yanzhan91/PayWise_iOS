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
    
    fileprivate var activityContainer: ActivityIndicator?
    
    fileprivate let noIntAlert = AlertFactory.getNoInternetAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityContainer = ActivityIndicator.init(parentView: self.view)
        self.activityContainer?.startActivityIndicator()
        self.getStores()
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    func getStores() {
        resourceGetService.getAllResource(resource: "/stores") { (response, error) in
            if (error != nil) {
                print(type(of: error!))
                print(error!.localizedDescription)
                self.present(self.noIntAlert, animated: true)
            } else {
                self.stores = response
                self.tableView.reloadData()
                self.activityContainer?.stopActivityIndicator()
            }
        }
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
            
        if (searchController.isActive && searchController.searchBar.text != "") {
            storeCell.textLabel?.text = self.filteredStores[indexPath.row]
        } else {
            storeCell.textLabel?.text = self.stores[indexPath.row]
        }
        
        return storeCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive && searchController.searchBar.text != "") {
            return filteredStores.count
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
