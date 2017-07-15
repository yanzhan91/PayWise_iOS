//
//  SecondViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit
import Alamofire

final class SecondViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier = "MyCardCell"
    fileprivate let cellSpacing = CGFloat(10.0)
    fileprivate let myCardService = MyCardsService()
    
    fileprivate let itemsPerRow: CGFloat = 2
    
    fileprivate var activityContainer : ActivityIndicator?
    
    fileprivate var myCards = [Card]()
    
    fileprivate var deleteMode = false
    
    var shouldRefreshCards = true
    
    override func viewWillAppear(_ animated: Bool) {
        if (self.shouldRefreshCards) {
            self.shouldRefreshCards = false
            self.activityContainer?.startActivityIndicator()
            myCardService.getMyCards() { (response, error) in
                if (error != nil) {
                    print(type(of: error!))
                    print(error!.localizedDescription)
                    self.shouldRefreshCards = true;
                    let noIntAlert = AlertFactory.getNoInternetAlert()
                    self.present(noIntAlert, animated: true)
                } else {
                    self.myCards = response
                    let defaults = UserDefaults.standard
                    defaults.set(self.myCards.count, forKey: "cardsAdded")
                    self.collectionView?.reloadData()
                }
                self.activityContainer?.stopActivityIndicator()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityContainer = ActivityIndicator.init(parentView: self.view)
        self.activityContainer?.startActivityIndicator()
    }
    
    @IBAction func addCards(_ sender: UIBarButtonItem) {
        let popover = PopoverController()
        popover.modalPresentationStyle = .popover
        self.navigationController!.pushViewController(popover, animated: true)
    }
    
    @IBAction func removeCard(_ sender: Any) {
        deleteMode = !deleteMode
        if (deleteMode) {
            self.navigationItem.rightBarButtonItems?[1].isEnabled = false
        } else {
            self.navigationItem.rightBarButtonItems?[1].isEnabled = true
        }
        self.collectionView?.reloadData()
    }
    
    @IBAction func deleteCard(_ sender: Any) {
        self.activityContainer?.startActivityIndicator()
        let button = sender as! UIButton
        print(button.tag)
        myCardService.deleteCard(cardName: myCards[button.tag].card_name) { json in
            print("deleting")
            print(json)
            self.collectionView?.reloadData()
            self.activityContainer?.stopActivityIndicator()
        }
        myCards.remove(at: button.tag)
        self.collectionView?.deleteItems(at: [IndexPath.init(row: button.tag, section: 0)])
    }
}

extension SecondViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return self.myCards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCardCell
        let cardInfo = self.myCards[indexPath.row]
        
        if (deleteMode) {
            cell.overlay.isHidden = false
        } else {
            cell.overlay.isHidden = true
        }

        let url = NSURL(string: cardInfo.card_img)
        cell.cardImage.image = UIImage.init(named: (url?.lastPathComponent)!)
        cell.cardName.text = cardInfo.card_name
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.backgroundColor = UIColor.white
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Heree")
        if (!deleteMode) {
            if let url = NSURL(string: myCards[indexPath.row].card_url) {
                UIApplication.shared.open(url as URL)
            }
        }
    }
}

extension SecondViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = cellSpacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 0.9)
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

