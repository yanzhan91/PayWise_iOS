//
//  PopoverController.swift
//  PayWise
//
//  Created by Yan Zhan on 6/3/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class PopoverController : UITableViewController {
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let resourceGetService = ResourceGetService()
    fileprivate let myCardsService = MyCardsService()
    
    fileprivate var allCards = [String]()
    fileprivate var filteredCards = [String]()
    
    override func viewDidLoad() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        print("Getting All Cards")
        resourceGetService.getAllCards() { response in
            self.allCards = response
            self.tableView.reloadData()
        }
    }
}

extension PopoverController : UISearchResultsUpdating {
    @available(iOS 8.0, *)
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)

    }

    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredCards = allCards.filter { card in
            return card.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}

extension PopoverController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredCards.count
        }
        return allCards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.textLabel?.text = filteredCards[indexPath.row]
        } else {
            cell.textLabel?.text = allCards[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedCard : String
        if searchController.isActive && searchController.searchBar.text != "" {
            selectedCard = filteredCards[indexPath.row]
        } else {
            selectedCard = allCards[indexPath.row]
        }
        
        myCardsService.addCard(cardName: selectedCard) { json in
            print(json)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
