//
//  FirstViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlacePicker

class FirstViewController : UIViewController {
    
    fileprivate var placePicker: GMSPlacePickerViewController!
    
    @IBOutlet weak var nearYouButton: UIButton?
    @IBOutlet weak var databaseButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        
        self.setButtonBorder()
    }
    
    func setButtonBorder() {
        self.nearYouButton?.backgroundColor = .clear
        self.nearYouButton?.layer.borderColor = self.nearYouButton?.currentTitleColor.cgColor
        self.nearYouButton?.layer.borderWidth = 1
        self.nearYouButton?.layer.cornerRadius = 5
        
        self.databaseButton?.backgroundColor = .clear
        self.databaseButton?.layer.borderColor = self.databaseButton?.currentTitleColor.cgColor
        self.databaseButton?.layer.borderWidth = 1
        self.databaseButton?.layer.cornerRadius = 5
    }
    
    @IBAction func findLocation(_ sender: Any) {
        self.present(placePicker, animated: true, completion: nil)
    }
}

extension FirstViewController : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print(place)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rewardsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsViewController
        rewardsVC.placeName = place.name
        viewController.dismiss(animated: true)
        self.navigationController?.pushViewController(rewardsVC, animated: true)
        
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        print(error)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
