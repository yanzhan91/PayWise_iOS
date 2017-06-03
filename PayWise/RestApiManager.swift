//
//  RestApiManager.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    func getResponse(completionHandler: @escaping (Array<Card>) -> Void) {
        Alamofire.request(
            URL(string:"https://m8n05huk4i.execute-api.us-east-1.amazonaws.com/dev/user-cards?user_id=10001")!,
            method: .get
            )
            .validate()
            .responseJSON { (response) -> Void in
                var cards = [Card]()
                guard response.result.isSuccess else {
                    print(response.result.error as Any)
                    return
                }
                let json = JSON(response.result.value!)
                json.array!.forEach() { jsonCard in
                    print(jsonCard["card_img"].rawString()!)
                    let card = Card(
                        fromImg: jsonCard["card_img"].rawString()!,
                        fromName: jsonCard["card_name"].rawString()!,
                        fromUrl: jsonCard["card_url"].rawString()!)
                    cards.append(card)
                }
                print(cards)
                completionHandler(cards as Array)
        }
    }
}
