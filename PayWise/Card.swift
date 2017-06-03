//
//  Card.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation

class Card {
    let card_img: String
    let card_name: String
    let card_url: String
    
    init(fromImg img: String, fromName name: String, fromUrl url: String) {
        self.card_img = img
        self.card_name = name
        self.card_url = url
    }
}
