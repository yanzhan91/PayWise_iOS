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

class FirstViewController : UICollectionViewController {
    
    fileprivate var placePicker: GMSPlacePickerViewController!
    
    fileprivate let resourceGetService = ResourceGetService()
    fileprivate var categories = [String]()
    
    fileprivate var activityContainer: ActivityIndicator?
    
    let cellSpacing = CGFloat(10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = GMSPlacePickerConfig(viewport: nil)
        placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        placePicker.modalPresentationStyle = .popover
        
        guard let navFrame = navigationController?.navigationBar.frame else{
            return
        }
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: navFrame.width, height: navFrame.height))
        let image = UIImageView(image: #imageLiteral(resourceName: "title"))
        image.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        image.center = myView.center
        myView.addSubview(image)
        myView.backgroundColor = .red
        self.navigationItem.titleView = myView
        
        self.collectionView?.delegate = self
        
        self.activityContainer = ActivityIndicator.init(parentView: self.view)
        self.activityContainer?.startActivityIndicator()
        resourceGetService.getAllResource(resource: "/categories") { (response, error) in
            
            if (error != nil) {
                print(type(of: error!))
                print(error!.localizedDescription)
                let noIntAlert = AlertFactory.getNoInternetAlert()
                self.present(noIntAlert, animated: true)
            } else {
                self.categories = response
                self.categories.append("MERCHANT")
                self.collectionView?.reloadData()
            }
            self.activityContainer?.stopActivityIndicator()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkForAddedCards()
    }
        
    @IBAction func showPlaces(_ sender: Any) {
        self.present(placePicker, animated: true, completion: nil)
    }
    
    func checkForAddedCards() {
        let defaults = UserDefaults.standard
        if (defaults.integer(forKey: "cardsAdded") == 0) {
            let addCardAlert = UIAlertController.init(title: "Add your cards", message: "To see your rewards, please first tell us what cards you have", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { action in
                self.tabBarController?.selectedIndex = 1
            }
            
            addCardAlert.addAction(OKAction)
            
            self.present(addCardAlert, animated: true)
        }
    }
}

extension FirstViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categorycell2", for: indexPath) as! CategoryCell
        let category = self.categories[indexPath.row]
        if (indexPath.row == self.categories.count - 1) {
            cell.title?.text = "Merchant (BETA)"
        } else {
            cell.title?.text = category
        }
        cell.image.image = UIImage(named: category)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (indexPath.row == self.categories.count - 1) {
            let vc = storyboard.instantiateViewController(withIdentifier: "MerchantVC") as! StoresViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let rewardsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsViewController
            rewardsVC.categoryName = self.categories[indexPath.row]
            self.navigationController?.pushViewController(rewardsVC, animated: true)
        }
    }
}

extension FirstViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow = CGFloat(3)
        let paddingSpace = cellSpacing * (itemsPerRow + 1)
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension FirstViewController : GMSPlacePickerViewControllerDelegate {
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        print(place)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let rewardsVC = storyboard.instantiateViewController(withIdentifier: "RewardsVC") as! RewardsViewController
//        rewardsVC.placeName = place.name
//        viewController.dismiss(animated: true)
//        self.navigationController?.pushViewController(rewardsVC, animated: true)
    }
    
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        print(error)
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
