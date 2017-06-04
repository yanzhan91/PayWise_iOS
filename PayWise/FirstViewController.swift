//
//  FirstViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlacePicker

class FirstViewController : UIViewController {

    fileprivate let user_id = UIDevice.current.identifierForVendor!.uuidString
    
    fileprivate let rewardsService = RewardsService()
    
    fileprivate var rewards = [Reward]()
    
    fileprivate var placePicker: GMSPlacePickerViewController!
    
    @IBOutlet weak var rewardsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
    }
    
    @IBAction func findLocation(_ sender: Any) {
        self.present(placePicker, animated: true, completion: nil)
    }
}

extension FirstViewController : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print(place)
        rewardsService.getRewards(name: place.name) { rewards in
            self.rewards = rewards
            self.rewardsTable.reloadData()
        }
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        print(error)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

extension FirstViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rewardsTable.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardsCell
        let reward = self.rewards[indexPath.row]
        cell.cardName.text = reward.cardName
        cell.cardImage.image = UIImage.init(named: "amazon-prime-rewards")
        cell.rewardPercent.text = String(reward.reward) + "%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewards.count
    }

    
}

