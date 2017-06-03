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
    
    func getResponse(urlPath: String, completionHandler: @escaping (JSON) -> Void) {
        Alamofire.request(
            URL(string: "https://m8n05huk4i.execute-api.us-east-1.amazonaws.com/dev" + urlPath)!,
            method: .get
            )
            .validate()
            .responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else {
                    print(response.result.error as Any)
                    return
                }
                let json = JSON(response.result.value!)
                
                completionHandler(json)
        }
    }
}
