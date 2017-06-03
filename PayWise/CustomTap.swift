//
//  CustomTap.swift
//  PayWise
//
//  Created by Yan Zhan on 6/2/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class CustomTap : UITapGestureRecognizer {
    var url: String? = nil
    
    convenience init(target: Any?, action: Selector?, url: String!) {
        self.init(target: target, action: action)
        self.url = url
    }
}
