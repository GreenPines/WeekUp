//
//  AddSummaryViewController.swift
//  LSRatingStar
//
//  Created by lion on 2017/7/19.
//  Copyright © 2017年 John_LS. All rights reserved.
//

//
//  UpTableViewController.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/12.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class AddMentionViewController: UIViewController {

    var textview: UITextView!
    var textPlaceholderLabel: UILabel!
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        
        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Add Mention"
        
        
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "closeIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddSummaryViewController.onReturn))
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationBar?.pushItem(navigationItem, animated: true)
        
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        view.addSubview(navigationBar!)
        navigationBar?.tintColor = UIColor.white
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 20)
        attrs[NSForegroundColorAttributeName] = UIColor.white
        navigationBar?.titleTextAttributes = attrs
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
        
        
        textview = UITextView(frame: CGRect(x: 36, y: 331, width: 320, height: 70))
        textview.font = UIFont.systemFont(ofSize: 25)
        
        textPlaceholderLabel = UILabel(frame: CGRect(x: 38, y: 331, width: 150, height: 34))
        textPlaceholderLabel.text = "Message"
        textPlaceholderLabel.font = UIFont(name: "Avenir", size: 25)
        textPlaceholderLabel.textColor = UIColor(red: 185/255, green: 194/255, blue: 206/255, alpha: 1.0)
        
        
        textview.delegate = self
        textview.backgroundColor = UIColor.clear
        
        view.addSubview(textPlaceholderLabel)
        view.addSubview(textview)
        
        //添加tableView
        tableView = UITableView(frame: CGRect(x: 0, y: 136, width: self.view.bounds.size.width, height:180), style: UITableViewStyle.plain)
        tableView!.delegate = self
        tableView!.dataSource = self
        self.view.addSubview(tableView)
        tableView.rowHeight = 50
        
        let cellNib = UINib(nibName: "MentionTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "MentionTableViewCell")
        
        //添加at view
        let topView = UIView(frame: CGRect(x: 0, y: 64, width: 375, height: 72))
        topView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        
        view.addSubview(topView)
        
        let atImg = UIImageView(frame: CGRect(x: 19, y: 20, width: 30, height: 30))
        atImg.image = #imageLiteral(resourceName: "at")
        topView.addSubview(atImg)
        
        let atField = UITextField(frame: CGRect(x: 60, y: 20, width: 270, height: 30))
        topView.addSubview(atField)

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onReturn() {
        print("text:\(textview.text)")
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension AddMentionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionTableViewCell", for: indexPath) as! MentionTableViewCell
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

extension AddMentionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AddMentionViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text != "" {
            textPlaceholderLabel.isHidden = true
        }
        
        if text == "" && range.location == 0 && range.length == 1 {
            textPlaceholderLabel.isHidden = false
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textview.resignFirstResponder()
        
    }
    
}


