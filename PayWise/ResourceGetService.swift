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
    
    func getAllResource(resource: String, completionHandler: @escaping (Array<String>) -> Void) {
        RestApiManager.sharedInstance.getResponse(urlPath: resource, method: "GET", parameters: nil) { json in
            
            var allResource = [String]()
            json.array!.forEach() { resource in
                allResource.append(resource.rawString()!)
            }
            
            completionHandler(allResource)
        }
    }
}
