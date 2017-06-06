//
//  DashLine.swift
//  PayWise
//
//  Created by Yan Zhan on 6/4/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class DashLine : UIView {
    override func draw(_ rect: CGRect) {
        let  path = UIBezierPath()
        
        let p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
        
        path.move(to: p0)
        
        let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
        path.addLine(to: p1)
        
        let dashWidth = self.bounds.width / 17
        
        let  dashes: [ CGFloat ] = [ dashWidth, dashWidth ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        path.lineWidth = 8.0
        path.lineCapStyle = .butt
        UIColor.black.set()
        path.stroke()
    }
}
