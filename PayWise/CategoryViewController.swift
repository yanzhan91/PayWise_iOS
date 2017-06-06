//
//  CategoryViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 6/5/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class CategoryViewController : UITableViewController {
    fileprivate let resourceGetService = ResourceGetService()
    fileprivate var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resourceGetService.getAllCategories() { response in
            self.categories = response
            self.tableView.reloadData()
        }
    }
}

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "CategoryCell")
        cell.textLabel?.text = self.categories[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsViewController
        rewardsVC.placeName = self.categories[indexPath.row]
        self.navigationController?.pushViewController(rewardsVC, animated: true)
    }
}

