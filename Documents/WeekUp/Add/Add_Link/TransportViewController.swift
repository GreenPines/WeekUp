//
//  TransportViewController.swift
//  Add_Link
//
//  Created by 沈松青 on 2017/7/17.
//  Copyright © 2017年 沈松青. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController {

    var urlLabel: UILabel!
    var textLabel: UILabel!
    var wifiImage: UIImageView!
    var webUploader: GCDWebUploader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        initView()
        let documentsPath = NSHomeDirectory() + "/Documents"
        webUploader = GCDWebUploader(uploadDirectory: documentsPath)
        webUploader.start(withPort: 8080, bonjourName: "Web Based Uploads")
        if let url = webUploader.serverURL {
            print("服务启动成功，使用你的浏览器访问：\(webUploader.serverURL)")
            urlLabel.text = webUploader.serverURL?.absoluteString
        } else {
           urlLabel.text = "请连入Wi-Fi网络" 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        let viewWidth = self.view.bounds.size.width
        let viewHeight = self.view.bounds.size.height
        
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.5)
        self.navigationItem.title = "Upload"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let item = UIBarButtonItem(image: UIImage(named: "closeIcon"), style: .plain, target: self, action: #selector(back(sender: )))
        item.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = item
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
        urlLabel = UILabel()
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(urlLabel)
        urlLabel.backgroundColor = UIColor.lightGray
        urlLabel.textAlignment = .center
        
        let urlLeft = NSLayoutConstraint(item: urlLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.15 * viewWidth)
        let urlBottom = NSLayoutConstraint(item: urlLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: -viewHeight * 0.15)
        let urlWidth = NSLayoutConstraint(item: urlLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewWidth * 0.7)
        let urlHeight = NSLayoutConstraint(item: urlLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewHeight * 0.05)
        NSLayoutConstraint.activate([urlLeft, urlBottom, urlWidth, urlHeight])
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor.lightGray
        view.addSubview(textLabel)
        textLabel.text = "请在电脑浏览器中访问以下地址上传文件\nPS:请将电脑端连入同一局域网(Wi-Fi)"
        textLabel.backgroundColor = UIColor.white
        textLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        textLabel.numberOfLines = 0
        
        let textLeft = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.05 * viewWidth)
        let textBottom = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.urlLabel, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: -viewHeight * 0.02)
        let textWidth = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewWidth * 0.9)
        let textHeight = NSLayoutConstraint(item: textLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewHeight * 0.15)
        NSLayoutConstraint.activate([textLeft, textBottom, textWidth, textHeight])

        wifiImage = UIImageView(image: (UIImage(named: "wifi")))
        view.addSubview(wifiImage)
        wifiImage.translatesAutoresizingMaskIntoConstraints = false
        let imageTop = NSLayoutConstraint(item: wifiImage, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.15 * viewHeight)
        let imageLeft = NSLayoutConstraint(item: wifiImage, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.05 * viewWidth)
        let imageWidth = NSLayoutConstraint(item: wifiImage, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewWidth * 0.9)
        let imageHeight = NSLayoutConstraint(item: wifiImage, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: viewHeight * 0.5)
        NSLayoutConstraint.activate([imageTop, imageLeft, imageWidth, imageHeight])
    }
    
    func back(sender: UIBarButtonItem) {
        webUploader.stop()
        self.dismiss(animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
