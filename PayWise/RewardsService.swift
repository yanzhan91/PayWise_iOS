//
//  RewardsService.swift
//  PayWise
//
//  Created by Yan Zhan on 6/3/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class RewardsService {
    let user_id = UIDevice.current.identifierForVendor!.uuidString
    
    func getRewards(name: String!, completionHandler: @escaping (Array<Reward>) -> Void) {
        
        let urlPath = "/rewards?user_id=" + user_id + "&name=" + (name.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!)
        print(urlPath)
        RestApiManager.sharedInstance.getResponse(urlPath: urlPath, method: "GET", parameters: nil) { json in
            var rewards = [Reward]()
            json.array!.forEach() { rewardJson in
                
                var descs = [String]()
                
                rewardJson["rewards_desc"].array!.forEach() { desc in
                    descs.append(desc.rawString()!)
                }
                
                rewards.append(Reward(
                    fromUrl: rewardJson["card_url"].rawString()!,
                    fromName: rewardJson["card_name"].rawString()!,
                    fromImg: rewardJson["card_img"].rawString()!,
                    fromReward: rewardJson["reward"].rawValue as! Double,
                    fromDesc: descs
                ))
            }
            
            completionHandler(rewards)
        }
    }
}
