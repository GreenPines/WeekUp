//
//  FileAttr.swift
//  Add_Link
//
//  Created by 沈松青 on 2017/7/14.
//  Copyright © 2017年 沈松青. All rights reserved.
//

import Foundation

class FileAttr {
    var name: String
    var ext: String
    var size: Double
    var creationDate: Date
    
    init() {
        name = ""
        ext = ""
        size = 0
        creationDate = Date()
    }
    
    func getSize() -> String {
        let sizeKB = size/1024
        let sizeMB = sizeKB/1024
        let sizeGB = sizeMB/1024
        var str = ""
        if sizeGB >= 1 {
            str = String(format: "%.2lf", sizeGB) + " GB"
        } else if sizeMB >= 1 {
            str = String(format: "%.2lf", sizeMB) + " MB"
        } else if sizeKB >= 1 {
            str = String(format: "%.2lf", sizeKB) + " KB"
        } else {
            str = String(format: "%.2lf", size) + " B"
        }
        return str
    }
    
    func getSubtitle() -> String {
        return getSize() + " " + ext.uppercased()
    }
    
    func iconType() -> String {
        switch ext {
        case "png","jpg","bmp":
            return "image"
        case "doc","docx":
            return "word"
        case "xls","xlsx":
            return "excel"
        case "ppt","pptx":
            return "ppt"
        case "pdf":
            return "pdf"
        default:
            return "question"
        }
    }
}
