//
//  profileViewController.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/14.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

protocol backToMine {
    func imageChange(img: UIImage)
    func nameTrans(name: String)
}

class profileViewController: UIViewController {
    
    var name:String!

    var profileTableView: UITableView!
    let userBut = UIButton(frame: CGRect(x: 145, y: 40, width: 86, height: 86))
    let cameraBut = UIButton(frame: CGRect(x: 211, y: 106, width: 20, height: 20))
    
    ////
    var delegate: backToMine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.title = "Profile"


        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBtnClick))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        //添加tableView
        profileTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.grouped)
        profileTableView!.delegate = self
        profileTableView!.dataSource = self
        self.view.addSubview(profileTableView)
        
        let cellNib = UINib(nibName: "weekCell", bundle: nil)
        profileTableView.register(cellNib, forCellReuseIdentifier: "weekCell")

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func leftBtnClick(){
        delegate?.imageChange(img: userBut.image(for: .normal)!)
        delegate?.nameTrans(name: name)
        _ = navigationController?.popViewController(animated: true)
    }
}


extension profileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:weekCell = tableView.dequeueReusableCell(withIdentifier: "weekCell") as! weekCell

            if indexPath.row == 0{
                cell.weekNo.text = "Username"
                cell.allAct.text = name
            }else if indexPath.row == 1{
                cell.weekNo.text = "Password"
                cell.allAct.text = "●●●●●●"
            }else if indexPath.row == 2{
                cell.weekNo.text = "Phone Number"
                cell.allAct.text = "+1 842-844-3201"
            }
        
        cell.weekNo.font = UIFont.systemFont(ofSize: 14)
        cell.allAct.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220))
        
        
        userBut.layer.cornerRadius = userBut.bounds.size.width / 2
        userBut.clipsToBounds = true
        userBut.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        
        self.view.addSubview(userBut)
        

        cameraBut.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        cameraBut.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        
        self.view.addSubview(cameraBut)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension profileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0{
            let alertController = UIAlertController(title: "系统登录", message: "请输入用户名和密码", preferredStyle: UIAlertControllerStyle.alert);
            alertController.addTextField { (textField:UITextField!) -> Void in
                textField.placeholder = "用户名";
            }
            alertController.addTextField { (textField:UITextField!) -> Void in
                textField.placeholder = "密码";
               // textField.secureTextEntry = true;
                textField.isSecureTextEntry = true
            }
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil )
            let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.default) { (ACTION) -> Void in
                let login = alertController.textFields!.first! as UITextField
                let passWord = alertController.textFields!.last! as UITextField
                print("用户名：\(login.text) 密码：\(passWord.text)");
            }
            alertController.addAction(cancelAction);
            alertController.addAction(okAction);
            self.present(alertController, animated: true, completion: nil)

        }
        
        if indexPath.row == 1{
            let alertController = UIAlertController(title: "密码修改", message: nil, preferredStyle: UIAlertControllerStyle.alert);
            alertController.addTextField { (textField:UITextField!) -> Void in
                textField.placeholder = "原密码";
            }
            alertController.addTextField { (textField:UITextField!) -> Void in
                textField.placeholder = "新密码";
                // textField.secureTextEntry = true;
                textField.isSecureTextEntry = true
            }
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil )
            let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (ACTION) -> Void in
                let login = alertController.textFields!.first! as UITextField
                let passWord = alertController.textFields!.last! as UITextField
                print("用户名：\(login.text) 密码：\(passWord.text)");
            }
            alertController.addAction(cancelAction);
            alertController.addAction(okAction);
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
}


extension profileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        userBut.setImage(info[UIImagePickerControllerEditedImage] as? UIImage, for: .normal)
        if let theImage = userBut.currentImage {
            show(image: theImage)
        }
        dismiss(animated: true, completion: nil)
    }
        
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func pickPhoto() {
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil,
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel,
                                         handler: nil)
        alertController.addAction(cancelAction)
//        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
        let chooseFromLibraryAction = UIAlertAction(
            title: "Choose From Library", style: .default,
            handler: { _ in self.choosePhotoFromLibrary() })
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func show(image: UIImage) {
        userBut.setImage(image, for: .normal)
    }
}


