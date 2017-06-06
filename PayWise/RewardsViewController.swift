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

        cell.CardDesc.attributedText = formatBulletParagraph(bulletArray: reward.rewardDesc)
        cell.rewardColor.backgroundColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 1)

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rewards.count
    }

    func formatBulletParagraph(bulletArray: Array<String>) -> NSAttributedString {
        
        var bullets = [String]()
        
        bulletArray.forEach() { bullet in
            bullets.append(bullet)
        }
        
        let attributesDictionary = [NSFontAttributeName : UIFont.init()]
        let fullAttributedString = NSMutableAttributedString(string: "", attributes: attributesDictionary)
        
        bullets.forEach() { bullet in
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(bullet)\n"
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString)
            
            let paragraphStyle = createParagraphAttribute()
            attributedString.addAttributes([NSParagraphStyleAttributeName: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
        
    }
    
    func createParagraphAttribute() ->NSParagraphStyle
    {
        var paragraphStyle: NSMutableParagraphStyle
        paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [String : AnyObject])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 15
        
        return paragraphStyle
    }
}
