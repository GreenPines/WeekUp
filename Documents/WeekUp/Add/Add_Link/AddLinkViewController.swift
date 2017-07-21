//
//  AddLinkMessageViewViewController.swift
//  Add_Link
//
//  Created by 沈松青 on 2017/7/11.
//  Copyright © 2017年 沈松青. All rights reserved.
//

import UIKit

class AddLinkViewController: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var linkImage: UIImageView!
    @IBOutlet weak var linkText: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var messageText: UITextField!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    var placeholderLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false

        initTextAttr()
        initNavBar()
        linkText.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
//        let addAttachmentNavi = UINavigationController(rootViewController: AddAttachmentViewController())
//        push(addAttachmentNavi)
    }
    
//    func initBar() {
//        navigationBar.tintColor = UIColor.red
//        navigationBar.titleTextAttributes
//    }
    
    func initNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.5)
        self.navigationItem.title = "Add Link"
        //navigationBar.topItem?.title = "Add Attachment"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let item = UIBarButtonItem(image: UIImage(named: "closeIcon"), style: .plain, target: self, action: #selector(back(sender: )))
        item.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = item
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
    }

    func initTextAttr() {
        //linktext
        linkText.keyboardType = UIKeyboardType.URL
        linkText.returnKeyType = UIReturnKeyType.done
        //messagetext
        messageText.returnKeyType = UIReturnKeyType.done
        messageText.delegate = self
        placeholderLabel = UILabel(frame: CGRect(x: 5, y: 0, width: 200, height: 30))
        placeholderLabel.font = UIFont.boldSystemFont(ofSize: 25)
        placeholderLabel.text = "Title Override"
        messageText.addSubview(placeholderLabel)
        placeholderLabel.textColor = UIColor.lightGray
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.placeholderLabel.isHidden = true
        return true
    }
    
    //MARK: Action
    func back(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
