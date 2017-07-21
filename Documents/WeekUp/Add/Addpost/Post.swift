//
//  Post.swift
//  Addpost
//
//  Created by Apple on 2017/7/17.
//  Copyright © 2017年 Apple. All rights reserved.
//
import Foundation
import UIKit
class Post: NSObject, NSCoding {
    var content: String = ""
    var title: String = ""
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "Title") as! String
        content = aDecoder.decodeObject(forKey: "Content") as! String
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "Title")
        aCoder.encode(content, forKey: "Content")
    }
    init(title: String, content: String) {
        self.title = title
        self.content = content
        super.init()
    }
    
}
