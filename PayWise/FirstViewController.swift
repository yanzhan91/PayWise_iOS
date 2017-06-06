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
    @IBOutlet weak var categoryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        
        self.setButtonBorder(button: self.nearYouButton!)
        self.setButtonBorder(button: self.databaseButton!)
        self.setButtonBorder(button: self.categoryButton)
    }
    
    func setButtonBorder(button: UIButton) {
        button.backgroundColor = .clear
        button.layer.borderColor = self.nearYouButton?.currentTitleColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
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
