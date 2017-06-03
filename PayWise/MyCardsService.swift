//
//  MyCardsService.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyCardsService {
    func getMyCards(completionHandler: @escaping (Array<Card>) -> Void) {
        RestApiManager.sharedInstance.getResponse(urlPath: "/user-cards?user_id=10001", method: "GET", parameters: nil) { json in
            
            var cards = [Card]()
            
            json.array!.forEach() { jsonCard in
                print(jsonCard["card_img"].rawString()!)
                let card = Card(
                    fromImg: jsonCard["card_img"].rawString()!,
                    fromName: jsonCard["card_name"].rawString()!,
                    fromUrl: jsonCard["card_url"].rawString()!)
                cards.append(card)
            }
            print(cards)
            
            completionHandler(cards)
        }
    }
    
    func addCard(cardName: String, completionHandler: @escaping (JSON) -> Void) {
        let parameters = [
            "user_id": "10001",
            "card_name": cardName
        ]
        RestApiManager.sharedInstance.getResponse(urlPath: "/user-cards", method: "POST", parameters: parameters) { json in
            completionHandler(json)
        }
    }
}
