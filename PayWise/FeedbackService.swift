//
//  FeedbackService.swift
//  PayWise
//
//  Created by Yan Zhan on 7/15/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedbackService {
    func postFeedback(email: String, face: String, suggestions: String, completionHandler: @escaping (JSON) -> Void) {
        let parameters = [
            "email": email,
            "review": face,
            "suggestions": suggestions
        ]
        RestApiManager.sharedInstance.getResponse(urlPath: "/feedbacks", method: "POST", parameters: parameters) { json, error in
            completionHandler(json!)
        }
    }
}
