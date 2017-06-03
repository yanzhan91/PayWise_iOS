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
        RestApiManager.sharedInstance.getResponse() { response in
            completionHandler(response)
        }
    }
}
