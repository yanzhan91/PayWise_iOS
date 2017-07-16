//
//  ThirdViewController.swift
//  PayWise
//
//  Created by Yan Zhan on 7/15/17.
//  Copyright © 2017 Yan Zhan. All rights reserved.
//

import UIKit

class ThirdViewController : UIViewController, UITextViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
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
        
        self.suggestions.returnKeyType = .done
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
    
//    func registerForKeyboardNotifications() {
//        print("Register")
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//    
//    func deregisterFromKeyboardNotifications() {
//        print("Deregister")
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//    }
//    
//    func keyboardWasShown(notification: NSNotification){
//        //Need to calculate keyboard exact size due to Apple suggestions
//        self.scrollView.isScrollEnabled = true
//        var info = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
//        
//        self.scrollView.contentInset = contentInsets
//        self.scrollView.scrollIndicatorInsets = contentInsets
//        
//        var aRect : CGRect = self.view.frame
//        aRect.size.height -= keyboardSize!.height
//        if let activeField = self.suggestions {
//            if (!aRect.contains(activeField.frame.origin)) {
//                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
//            }
//        }
//    }
//    
//    func keyboardWillBeHidden(notification: NSNotification){
//        //Once keyboard disappears, restore original positions
//        var info = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
//        self.scrollView.contentInset = contentInsets
//        self.scrollView.scrollIndicatorInsets = contentInsets
//        self.view.endEditing(true)
//        self.scrollView.isScrollEnabled = false
//    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if (text == "\n") {
//            textView.resignFirstResponder()
//        }
//        return true
//    }
    
//    func hideKeyboard() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
//            target: self,
//            action: #selector(dismissKeyboard))
//        
//        self.view.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard() {
//        textViewDidEndEditing(self.activeTextView!)
//    }

}
