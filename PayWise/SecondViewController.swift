//
//  SecondViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 5/28/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

final class SecondViewController: UICollectionViewController {
    
    fileprivate let reuseIdentifier = "MyCardCell"
    fileprivate let cellSpacing = CGFloat(10.0)
    fileprivate let myCardService = MyCardsService()
    
    fileprivate let itemsPerRow: CGFloat = 2
    
    fileprivate var myCards = [Card]()
    
    override func viewWillAppear(_ animated: Bool) {
        myCardService.getMyCards() { response in
            self.myCards = response
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addCards(_ sender: UIBarButtonItem) {
        let popover = PopoverController()
        popover.modalPresentationStyle = .popover
        self.navigationController!.pushViewController(popover, animated: true)//present(popover, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension SecondViewController {
    //1
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        print(self.myCards.count)
        return self.myCards.count
    }
    
    //3
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCardCell
        let cardInfo = self.myCards[indexPath.row]
        cell.cardImage.image = UIImage.init(named: "amazon-prime-rewards")
        
        let tapGestureRecognizer = CustomTap(target: self, action: #selector(linkTapped), url: cardInfo.card_url)
        cell.cardImage.addGestureRecognizer(tapGestureRecognizer)
        cell.cardImage.isUserInteractionEnabled = true
        
        cell.cardName.text = cardInfo.card_name
        cell.backgroundColor = UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       blue:  CGFloat(arc4random()) / CGFloat(UInt32.max),
                                       alpha: 1.0)
        return cell
    }
    
    func linkTapped(sender: CustomTap) {
        if let url = NSURL(string: sender.url!) {
            UIApplication.shared.open(url as URL)
        }
    }
}

extension SecondViewController : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = cellSpacing * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 0.75)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

