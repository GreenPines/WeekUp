//
//  AddPostViewController.swift
//  Addpost
//
//  Created by Apple on 2017/7/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController {
    @IBOutlet weak var contenttext: UITextField!
    @IBOutlet weak var titletext: UITextField!
//    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var PostToEdit: Post?
    
    var titile: String = ""
    var content: String = ""
    
    
    
    @IBAction func done(){
        if let item = PostToEdit {
            item.title = titletext.text!
            item.content = contenttext.text!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addtoolbar(textfield: titletext)
        addtoolbar(textfield: contenttext)
        if let post = PostToEdit {
            
            titile = titletext.text!
            content = contenttext.text!
            //doneBarButton.isEnabled = true
        }
        
        initNavBar()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func closebutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func initNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.5)
        self.navigationItem.title = "Add Post"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let item = UIBarButtonItem(image: UIImage(named: "closeIcon"), style: .plain, target: self, action: #selector(back(sender: )))
        item.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = item
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
    }
    func back(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}
extension AddPostViewController: UITextFieldDelegate{
    func addtoolbar(textfield: UITextField){
        var toolbar: UIToolbar = UIToolbar();
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.frame = CGRect(x: 0, y: 0, width: 375, height: 35)
        //toolbar.tintColor = UIColor.blue;
        toolbar.tintColor = UIColor(red: 127/255, green: 143/255, blue: 164/255, alpha: 100)
        toolbar.backgroundColor = UIColor.gray
        
        var jinghao: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "jinghao"), style: UIBarButtonItemStyle.plain, target: self, action: "addjinghao")
        var image: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "image1"), style: UIBarButtonItemStyle.plain, target: self, action: "chooseimage")
        var link: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "link1"), style: UIBarButtonItemStyle.plain, target: self, action: "addlink")
        var aite: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "aite"), style: UIBarButtonItemStyle.plain, target: self, action: "aitesomeone")
        toolbar.setItems([jinghao,image,link,aite], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        textfield.delegate = self
        textfield.inputAccessoryView = toolbar
    }
    func aitesomeone(){
        
    }
    
    func addlink() {
        
    }
    
    func addjinghao() {
    }
    
    
    func chooseimage() {
    }
}
