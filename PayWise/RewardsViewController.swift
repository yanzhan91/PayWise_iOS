//
//  RewardsViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 6/5/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class RewardsViewController : UITableViewController {
    fileprivate let rewardsService = RewardsService()
    
    fileprivate var rewards = [Reward]()
    
    var placeName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rewardsService.getRewards(name: placeName!) { rewards in
            self.rewards = rewards
            self.tableView.reloadData()
        }
    }
}

extension RewardsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RewardsCell", for: indexPath) as! RewardsCell
        let reward = self.rewards[indexPath.row]
        cell.cardName.text = reward.cardName
        cell.cardImage.image = UIImage.init(named: "amazon-prime-rewards")
        cell.rewardPercent.text = String(reward.reward) + "%"

        cell.CardDesc.text = "Hello World"
        cell.rewardColor.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 1)

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewards.count
    }


}
