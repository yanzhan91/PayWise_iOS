//
//  AlertFactory.swift
//  PayWise
//
//  Created by Yan Zhan on 6/15/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class AlertFactory {
    class func getNoInternetAlert() -> UIAlertController {
        let noIntAlert = UIAlertController.init(title: "No Internet", message: "The internet connection appears to be offline", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        noIntAlert.addAction(action)
        return noIntAlert
    }
}
