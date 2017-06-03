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
    
    let user_id = UIDevice.current.identifierForVendor!.uuidString
    
    func getMyCards(completionHandler: @escaping (Array<Card>) -> Void) {
        RestApiManager.sharedInstance.getResponse(urlPath: "/user-cards?user_id=" + user_id, method: "GET", parameters: nil) { json in
            
            var cards = [Card]()
            
            json.array!.forEach() { jsonCard in
                let card = Card(
                    fromImg: jsonCard["card_img"].rawString()!,
                    fromName: jsonCard["card_name"].rawString()!,
                    fromUrl: jsonCard["card_url"].rawString()!)
                cards.append(card)
            }
            
            completionHandler(cards)
        }
    }
    
    func addCard(cardName: String, completionHandler: @escaping (JSON) -> Void) {
        let parameters = [
            "user_id": user_id,
            "card_name": cardName
        ]
        RestApiManager.sharedInstance.getResponse(urlPath: "/user-cards", method: "POST", parameters: parameters) { json in
            completionHandler(json)
        }
    }
    
    func deleteCard(cardName: String, completionHandler: @escaping (JSON) -> Void) {
        let urlPath = "/user-cards?user_id="+user_id+"&card_name=" + cardName.replacingOccurrences(of: " ", with: "%20")
        RestApiManager.sharedInstance.getResponse(urlPath: urlPath, method: "DELETE", parameters: nil) { json in
            completionHandler(json)
        }
    }
}
