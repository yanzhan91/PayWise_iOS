//
//  CustomTap.swift
//  PayWise
//
//  Created by Yan Zhan on 6/2/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class CustomTap : UITapGestureRecognizer {
    var url: String!
    var indexPath: IndexPath!
    
    convenience init(target: Any?, action: Selector?, url: String!, indexPath: IndexPath!) {
        self.init(target: target, action: action)
        self.url = url
        self.indexPath = indexPath
    }
}
