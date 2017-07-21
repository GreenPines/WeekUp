//
//  AddAttachmentViewController.swift
//  Add_Link
//
//  Created by 沈松青 on 2017/7/11.
//  Copyright © 2017年 沈松青. All rights reserved.
//

import UIKit

class AddAttachmentViewController: UIViewController {
    
//    var navigationBar: UINavigationBar!
    var tableView: UITableView!
    var smallView: UIView! //a label and a + button
    var fileLabel: UILabel! // "Your files"
    var addButton: UIButton!
    //var addTextButton: UIButton!
    var data = ["数据0","数据1","数据2","数据3","数据4","数据5","数据6","数据7","数据8","数据9","数据10","数据11"]
    var fileList = [FileAttr]()
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFileList()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        initNavBar()
        print("Bar height: \(self.navigationController?.navigationBar.frame.size.height)")
        let tempy = (self.navigationController?.navigationBar.frame.origin.y)! + (self.navigationController?.navigationBar.frame.size.height)!
        print("\(self.navigationController?.navigationBar.frame.origin.y)  \(tempy) ")
//        frame: CGRect(x: 0, y: tempy+20 , width: self.view.bounds.size.width, height: 44)
        smallView = UIView()
        view.addSubview(smallView)
        smallView.layer.borderColor = UIColor.lightGray.cgColor
        smallView.translatesAutoresizingMaskIntoConstraints = false
        let smallViewTop = NSLayoutConstraint(item: smallView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 64)
        let smallViewWidth = NSLayoutConstraint(item: smallView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: self.view.frame.width)
        let smallViewHeight = NSLayoutConstraint(item: smallView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 0.125 * self.view.frame.height)
        let smallViewLeft = NSLayoutConstraint(item: smallView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([smallViewTop, smallViewWidth, smallViewHeight, smallViewLeft])
        
        print("subview y: \(smallView.frame.origin.y)")
        fileLabel = UILabel(frame: CGRect(x: 17, y: 9, width: 100, height: 22))
        fileLabel.text = "Your files"
        fileLabel.font = UIFont.systemFont(ofSize: 24)
        smallView.addSubview(fileLabel)
        fileLabel.translatesAutoresizingMaskIntoConstraints = false
        let labelHieght = NSLayoutConstraint(item: fileLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 0.101 * self.view.frame.height)
        let labelLeft = NSLayoutConstraint(item: fileLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.smallView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 8)
        let labelWidth = NSLayoutConstraint(item: fileLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 100)
        let labelTop = NSLayoutConstraint(item: fileLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.smallView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.012 * self.view.frame.height)
        NSLayoutConstraint.activate([labelHieght, labelLeft, labelWidth, labelTop])
        
        addButton = UIButton(type: .contactAdd)
        addButton.frame = CGRect(x: 250, y: 6 , width: 100 , height: 32)
        addButton.setTitle(" Add a File", for: .normal)
        addButton.setTitleColor(UIColor.black, for: .normal)
        addButton.tintColor = UIColor.black
        smallView.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonRight = NSLayoutConstraint(item: addButton, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.smallView, attribute: NSLayoutAttribute.right, multiplier: 1.0, constant: -8)
        let buttonWidth = NSLayoutConstraint(item: addButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 120)
        let buttonHeight = NSLayoutConstraint(item: addButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 0.101 * self.view.frame.height)
        let buttonTop = NSLayoutConstraint(item: addButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.smallView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.012 * self.view.frame.height)
        NSLayoutConstraint.activate([buttonRight, buttonWidth, buttonHeight, buttonTop])
        addButton.addTarget(self, action: #selector(addFile), for: .touchUpInside)
        smallView.backgroundColor = UIColor.white
        
        
        
       
        initTableView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNavBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 0.5)
        self.navigationItem.title = "Add Attachment"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let item = UIBarButtonItem(image: UIImage(named: "closeIcon"), style: .plain, target: self, action: #selector(back(sender: )))
        item.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = item
//        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
    }
    func initTableView() {
        print("smallView \(smallView.frame.maxY)")
//        frame: CGRect(x: 0,y: smallView.frame.maxY, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        tableView = UITableView()
        tableView.dataSource = self
        let cellNib = UINib(nibName: "AddAttachmentCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "AddAttachmentCell")
        tableView.rowHeight = 66
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        print("\(self.smallView.frame.origin.y) \(self.smallView.frame.height)")
        let tableViewTop = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.smallView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        let tableViewLeading = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let tableViewTrailing = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: self.tableView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([tableViewTop, tableViewLeading, tableViewTrailing, tableViewBottom])
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        tableView.addSubview(refreshControl)
    }
    
    func refresh() {
        fileList.removeAll()
        loadFileList()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func back(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:documents
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadFileList() {
        print("\(documentsDirectory())")
        //need interface
        //fileList.removeAll()
        let fileMngr = FileManager.default
        let path = fileMngr.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        print("file path \(path)")
        let content = try? fileMngr.contentsOfDirectory(atPath: path)
        print("\(content?.count) \(content)")
        //        for (index,file) in (content?.enumerated())! {
        //            print("\(index) \(")
        //        }
        var theCreationDate = Date()
        var theFileSize: UInt64 = 0
        if let content = content  {
            if content.count > 0 {
                for id in 0...content.count - 1{
                    //print("for content \(content)")
                    print("id: \(id)")
                    //fileList[id] = FileAttr()
                    let nowfile = FileAttr()
                    let filename = content[id]
                    let pathExtension = (filename as NSString).pathExtension
                    nowfile.ext = pathExtension
                    let pathPrefix = (filename as NSString).deletingPathExtension
                    nowfile.name = pathPrefix
                    let filepath = path + "/" + filename
                    // print("Path:" + filepath)
                    do {
                        let aFileAtrributes = try fileMngr.attributesOfItem(atPath: filepath)
                        theCreationDate = aFileAtrributes[FileAttributeKey.creationDate] as! Date
                        nowfile.creationDate = theCreationDate
                        theFileSize = aFileAtrributes[FileAttributeKey.size] as! UInt64
                        nowfile.size = Double(theFileSize)
                        //                    let theType = aFileAtrributes[FileAttributeKey.type] as! String
                        //                    print("Type: \(theType)")
                    } catch let error as Error {
                        print("file not found \(error)")
                    }
                    print("\(pathExtension) \(pathPrefix) \(theCreationDate) \(theFileSize)\n")
                    fileList.append(nowfile)
                }
            } else {
                print("There is no file")
            }
        }
        
        fileList.sort(by: {cl1, cl2 in
            return cl1.creationDate.compare(cl2.creationDate) == .orderedDescending })

    }
    func addFile() {
        let controller = UINavigationController(rootViewController: TransportViewController())
        self.present(controller, animated: true, completion: nil)
    }
}

extension AddAttachmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddAttachmentCell", for: indexPath) as! AddAttachmentCell
        let id = indexPath.row
        cell.nameLabel.text = fileList[id].name
        cell.attrLabel.text = fileList[id].getSubtitle()
        cell.iconImage.image = UIImage(named: fileList[id].iconType())
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let fileMngr = FileManager.default
        let path = fileMngr.urls(for: .documentDirectory, in: .userDomainMask)[0].path
        let filePathName = "\(path)/\(fileList[indexPath.row].name).\(fileList[indexPath.row].ext)"
        print("The file to delete: \(filePathName)")
        do {
            try fileMngr.removeItem(atPath: filePathName)
        } catch {
            print("delete error")
        }

        fileList.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

}

extension AddAttachmentViewController: UITextViewDelegate {
    
}
