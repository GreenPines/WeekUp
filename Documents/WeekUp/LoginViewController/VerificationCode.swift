//
//  VerificationCode.swift
//  WeekUp
//
//  Created by 万大千 on 2017/7/12.
//  Copyright © 2017年 万大千. All rights reserved.
//

import UIKit

class VerificationCode: UIViewController,UITextFieldDelegate {
    var ta=false
    @IBOutlet weak var t1: UITextField!
    @IBOutlet weak var t2: UITextField!
    @IBOutlet weak var t3: UITextField!
    @IBOutlet weak var t4: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        t1.becomeFirstResponder()
        t1.delegate=self
        t2.delegate=self
        t3.delegate=self
        t4.delegate=self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if (textField == self.t1){
            
            let oldText1 = textField.text! as NSString
            let newText1 = oldText1.replacingCharacters(in: range, with: string) as NSString
            if (newText1.length == 1) {
               
               t1.resignFirstResponder()
                t2.becomeFirstResponder()
            }
           
        }else if(textField == self.t2){
            let oldText2 = textField.text! as NSString
            let newText2 = oldText2.replacingCharacters(in: range, with: string) as NSString
            if (newText2.length == 2) {
                t2.resignFirstResponder()
                t3.becomeFirstResponder()
            }
            
        }else if(textField == self.t3){
            let oldText2 = textField.text! as NSString
            let newText2 = oldText2.replacingCharacters(in: range, with: string) as NSString
            if (newText2.length == 2) {
                t3.resignFirstResponder()
                t4.becomeFirstResponder()
            }
            
        }
       
        return true
    }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
