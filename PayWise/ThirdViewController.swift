//
//  ThirdViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 7/15/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class ThirdViewController : UIViewController, UITextViewDelegate {
    @IBOutlet weak var headerText: UILabel!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var sadFace: UIButton!
    @IBOutlet weak var confusedFace: UIButton!
    @IBOutlet weak var happyFace: UIButton!
    
    @IBOutlet weak var suggestions: UITextView!
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    
    fileprivate var faceChosen = "0"
    
    fileprivate let feedbackService = FeedbackService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sadFace.setImage(#imageLiteral(resourceName: "Sad_gray"), for: .normal)
        self.confusedFace.setImage(#imageLiteral(resourceName: "Confused_gray"), for: .normal)
        self.happyFace.setImage(#imageLiteral(resourceName: "Happy_gray"), for: .normal)
        
        self.suggestions.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        deregisterFromKeyboardNotifications()
    }
    
    @IBAction func sadFacePressed(_ sender: Any) {
        self.headerText.text = "We're suppose you don't like our app. Please help us with suggestions below."
        self.sadFace.setImage(#imageLiteral(resourceName: "Sad"), for: .normal)
        self.confusedFace.setImage(#imageLiteral(resourceName: "Confused_gray"), for: .normal)
        self.happyFace.setImage(#imageLiteral(resourceName: "Happy_gray"), for: .normal)
        self.sendButton.isEnabled = true
        self.faceChosen = "1"
    }
    
    @IBAction func confusedFacePressed(_ sender: Any) {
        self.headerText.text = "Please help us with suggestions below."
        self.sadFace.setImage(#imageLiteral(resourceName: "Sad_gray"), for: .normal)
        self.confusedFace.setImage(#imageLiteral(resourceName: "Confused"), for: .normal)
        self.happyFace.setImage(#imageLiteral(resourceName: "Happy_gray"), for: .normal)
        self.sendButton.isEnabled = true
        self.faceChosen = "2"
    }
    
    @IBAction func happyFacePressed(_ sender: Any) {
        self.headerText.text = "We're glad you like our app. Please help us improve with suggestions."
        self.sadFace.setImage(#imageLiteral(resourceName: "Sad_gray"), for: .normal)
        self.confusedFace.setImage(#imageLiteral(resourceName: "Confused_gray"), for: .normal)
        self.happyFace.setImage(#imageLiteral(resourceName: "Happy"), for: .normal)
        self.sendButton.isEnabled = true
        self.faceChosen = "3"
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        feedbackService.postFeedback(email: self.email.text!, face: faceChosen, suggestions: self.suggestions.text) { json in
            print(json)
            self.sadFace.setImage(#imageLiteral(resourceName: "Sad_gray"), for: .normal)
            self.confusedFace.setImage(#imageLiteral(resourceName: "Confused_gray"), for: .normal)
            self.happyFace.setImage(#imageLiteral(resourceName: "Happy_gray"), for: .normal)
            self.sendButton.isEnabled = false
            self.suggestions.text = ""
            self.headerText.text = "We deeply appreciate your feedback."
        }
    }
}
