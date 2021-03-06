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
    
    func getResponse(urlPath: String, method: String, parameters: Dictionary<String, String>?, completionHandler: @escaping (JSON?, Error?) -> Void) {
        Alamofire.request(
                URL(string: "https://m8n05huk4i.execute-api.us-east-1.amazonaws.com/prod" + urlPath)!,
                method: HTTPMethod.init(rawValue: method)!,
                parameters: parameters,
                encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) -> Void in
                if response.result.isFailure {
                    completionHandler([:], response.result.error)
                } else {
                    let json = JSON(response.result.value!)
                    completionHandler(json, response.result.error)
                }
        }
    }
}
