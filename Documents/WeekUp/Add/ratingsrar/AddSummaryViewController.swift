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

class AddSummaryViewController: UIViewController {
    
    var textLabel: UILabel!
    var star: LSRatingStar!
    var textview: UITextView!
    var textPlaceholderLabel: UILabel!
    var bgImageView: UIImageView!
    
    
    override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.white
        super.viewDidLoad()
        
        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "Add Summary"
        
        
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
        
        
        textLabel = UILabel(frame: CGRect(x: 25, y: 89, width: 150, height: 25))
        textLabel.text = "Self Assessment"
        textLabel.font = UIFont(name: "Avenir", size: 18)
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
        textLabel.textColor = UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1.0)
        view.addSubview(textLabel)
        //字体名称都有哪些 我们可以通过如下方法得到
//        let arr = UIFont.familyNames
//        print(arr)
        bgImageView = UIImageView(frame: CGRect(x: 180, y: 85, width: 140, height: 30))

        bgImageView.image = #imageLiteral(resourceName: "starbg")
        view.addSubview(bgImageView)
        
        star = LSRatingStar.init(frame: CGRect(x: 190, y: 85, width: 120, height: 30))
        view.addSubview(star)
        
        textview = UITextView(frame: CGRect(x: 36, y: 135, width: 320, height: 270))
        textview.font = UIFont.systemFont(ofSize: 25)
        
        textPlaceholderLabel = UILabel(frame: CGRect(x: 38, y: 143, width: 150, height: 34))
        textPlaceholderLabel.text = "Postscript"
        textPlaceholderLabel.font = UIFont(name: "Avenir", size: 25)
        textPlaceholderLabel.textColor = UIColor(red: 185/255, green: 194/255, blue: 206/255, alpha: 1.0)

        
        textview.delegate = self
        textview.backgroundColor = UIColor.clear
        
        view.addSubview(textPlaceholderLabel)
        view.addSubview(textview)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onReturn() {
        print("rating:\(star.rating)")
        print("text:\(textview.text)")
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension AddSummaryViewController: UITextViewDelegate {
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


