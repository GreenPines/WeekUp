//
//  Signup.swift
//  WeekUp
//
//  Created by 万大千 on 2017/7/11.
//  Copyright © 2017年 万大千. All rights reserved.
//

import UIKit

class Signup: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var lets: UIButton!
    @IBOutlet weak var buttonbo: NSLayoutConstraint!
    
    var a = false
    var b = false

    override func viewDidLoad() {
        super.viewDidLoad()
        phonenumber.delegate=self
       password.delegate=self
        phonenumber.becomeFirstResponder()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
    }
    func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            //self.view.setNeedsLayout()
            //改变下约束
            self.buttonbo.constant = intersection.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            _ in
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if (textField == self.phonenumber){
            
           let oldText1 = textField.text! as NSString
           let newText1 = oldText1.replacingCharacters(in: range, with: string) as NSString
           if (newText1.length > 0) {
            a = true
           } else {
            a = false
           }
        }else if(textField == self.password){
            let oldText2 = textField.text! as NSString
            let newText2 = oldText2.replacingCharacters(in: range, with: string) as NSString
            if (newText2.length > 0) {
                b = true
            } else {
                b = false
            }
            
        }

        if(a&&b){
            lets.isEnabled=true
        }
        
        return true
    }
    
    @IBAction func letsweekup(_ sender: UIButton) {
        self.present(AllTabBarController(), animated: true, completion: nil)
    }
    @IBAction func cac(_ sender: UIButton) {
    }
    @IBAction func back(_ sender: Any) {
        //self.dismiss(animated: true, completion: nil)
        self.present(Walkthrough(), animated: true, completion: nil)
    }
   

}
