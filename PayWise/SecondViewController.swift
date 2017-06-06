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
    
    fileprivate var myCards = [Card]()
    
    fileprivate var deleteMode = false
    
    override func viewWillAppear(_ animated: Bool) {
        myCardService.getMyCards() { response in
            self.myCards = response
            let defaults = UserDefaults.standard
            defaults.set(self.myCards.count, forKey: "cardsAdded")
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.cardImage.image = UIImage.init(named: "amazon-prime-rewards")
        cell.cardName.text = cardInfo.card_name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (deleteMode) {
            myCardService.deleteCard(cardName: myCards[indexPath.row].card_name) { json in
                print("deleteing")
                print(json)
            }
            print(indexPath.row)
            myCards.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        } else {
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
        
        return CGSize(width: widthPerItem, height: widthPerItem * 0.75)
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

