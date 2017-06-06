//
//  ResourceGetService.swift
//  PayWise
//
//  Created by Yan Zhan on 6/3/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class ResourceGetService {
    func getAllCards(completionHandler: @escaping (Array<String>) -> Void) {
        
        RestApiManager.sharedInstance.getResponse(urlPath: "/cards", method: "GET", parameters: nil) {
            json in
            
            var allCards = [String]()
            json.array!.forEach() { cardName in
                allCards.append(cardName.rawString()!)
            }
            
            completionHandler(allCards)
        }
    }
    
    func getAllStores(completionHandler: @escaping (Array<String>) -> Void) {
        RestApiManager.sharedInstance.getResponse(urlPath: "/stores", method: "GET", parameters: nil) { json in
            
            var allStores = [String]()
            json.array!.forEach() { store in
                allStores.append(store.rawString()!)
            }
            
            completionHandler(allStores)
        }
    }
    
    func getAllCategories(completionHandler: @escaping (Array<String>) -> Void) {
        RestApiManager.sharedInstance.getResponse(urlPath: "/categories", method: "GET", parameters: nil) { json in
            
            var allCategories = [String]()
            json.array!.forEach() { category in
                allCategories.append(category.rawString()!)
            }
            
            completionHandler(allCategories)
        }
    }
}
