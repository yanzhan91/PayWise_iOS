//
//  Reward.swift
//  PayWise
//
//  Created by Yan Zhan on 6/3/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation

class Reward {
    let cardUrl: String
    let cardName: String
    let cardImg: String
    let reward: Double
    let rewardDesc: Array<String>
    
    init(fromUrl url: String, fromName name: String, fromImg img: String, fromReward reward: Double, fromDesc desc: Array<String>) {
        self.cardUrl = url
        self.cardName = name
        self.cardImg = img
        self.reward = reward
        self.rewardDesc = desc
    }
}
