//
//  ActivityIndicator.swift
//  PayWise
//
//  Created by Yan Zhan on 6/7/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class ActivityIndicator : UIView {
    
    fileprivate let loadingView = UIView()
    fileprivate let actInd = UIActivityIndicatorView()
    
    init(parentView: UIView) {
        super.init(frame: parentView.frame)
        self.center = parentView.center
        self.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3)

        self.setupLoadingView(uiView: parentView)
        self.setupActivityIndicator()
        
        self.loadingView.addSubview(self.actInd)
        self.addSubview(self.loadingView)
        parentView.addSubview(self)
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startActivityIndicator() {
        self.actInd.startAnimating()
        self.isHidden = false
    }
    
    func stopActivityIndicator() {
        self.actInd.stopAnimating()
        self.isHidden = true
    }
    
    fileprivate func setupLoadingView(uiView: UIView) {
        self.loadingView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 80)
        self.loadingView.center = uiView.center
        self.loadingView.backgroundColor = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 0.7)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
    }
    
    fileprivate func setupActivityIndicator() {
        self.actInd.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.actInd.center = CGPoint.init(x: self.loadingView.frame.size.width / 2, y: self.loadingView.frame.size.height / 2)
    }
}
