//
//  CreateTeamViewController.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/18.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class CreateTeamViewController: UIViewController {
    
    var createTeamTableView: UITableView!
    var teamNameArr =
        ["Mazeal", "Alibaba", "Tencent"]
    var teamImageArr =
        ["Oval","checklist","Oval 2"]
    
    var userNameArr = ["Mary","John","Judy","Mary","John","Judy","Mary","John","Judy"]
    var userimageArr = ["Oval","checklist","Oval 2","Oval","checklist","Oval 2","Oval","checklist","Oval 2"]
    var flag: Bool = true
    var flags:Array<Int> = []
    let teamBtn = UIButton(frame: CGRect(x: 145, y: 41, width: 86, height: 86))
    let cameraBut = UIButton(frame: CGRect(x: 211, y: 107, width: 20, height: 20))
    
    //MARK: - Construction method
    //必须重写此方法，UITableViewController才能成功调用空的构造方法
    //    override init(style: UITableViewStyle) {
    //        super.init(style: style)
    //        print(#function)
    //    }
    
    //必须重写此方法，否则编译无法通过
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(#function)
    }
    
    //重写此方法使得UITableViewController能够调用空的构造方法
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flags = Array<Int>(repeating: 1, count:userNameArr.count)
        
        teamBtn.setImage(#imageLiteral(resourceName: "icon-1"), for: .normal)
        
        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        let navigationItem = UINavigationItem()
        navigationItem.title = "TeamCreate"
        //*修改title颜色
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = UIFont(name: "Avenir-Heavy", size: 17)
        attrs[NSForegroundColorAttributeName] = UIColor.white
        navigationBar?.titleTextAttributes = attrs
        
        
        //BarButton
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "return"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(Return))
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        
        let rightBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(Done))
        navigationItem.setRightBarButton(rightBtn, animated: true)
        rightBtn.isEnabled = false
        
        navigationBar?.pushItem(navigationItem, animated: true)
        
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        navigationBar?.tintColor = UIColor.white
        
        
        view.addSubview(navigationBar!)
        
        //添加createTeamTableView
        createTeamTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height-64), style: UITableViewStyle.grouped)
        createTeamTableView!.delegate = self
        createTeamTableView!.dataSource = self
        self.view.addSubview(createTeamTableView)
        //createTeamTableView.register(UINib.init(nibName: "setTeamNameCell", bundle: nil), forCellReuseIdentifier: setTeamNameCell.reuseIdentifier)
        //createTeamTableView.register(TeamMemberCell.self, forCellReuseIdentifier: TeamMemberCell.reuseIdentifier)
        //createTeamTableView.rowHeight = UITableViewAutomaticDimension
        
        //createTeamTableView.setEditing(true, animated: true)
        
        var cellNib = UINib(nibName: "AddedUserCell", bundle: nil)
        createTeamTableView.register(cellNib, forCellReuseIdentifier: "AddedUserCell")
        
        cellNib = UINib(nibName: "ResendSMSCell", bundle: nil)
        createTeamTableView.register(cellNib, forCellReuseIdentifier: "ResendSMSCell")
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text)
        return true;
    }
    
    func Done() {
        //delegate?.returnTeam(teams: teams, showTeams: showTeams)
        dismiss(animated: true, completion: nil)
    }
    
    func Return() {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CreateTeamViewController: UITableViewDataSource {
    
    //    分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //    分区的行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }else {
            return 1
        }
        
    }
    //    每行的高度
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //        if indexPath.section == 0{
        //            return 80
        //        }else if indexPath.section == 1{
        //            return 40
        //        }else if indexPath.section == 2{
        //            return 72
        //        }else {
        //            return 64
        //        }
        //Choose your custom row height
        return 64
    }
    
    //    行显示的内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = createTeamTableView.dequeueReusableCell(withIdentifier: "TeamMemberCell", for: indexPath) as! TeamMemberCell
        //        let cell:TeamMemberCell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberCell") as! TeamMemberCell
        //        cell.avatar.image = UIImage(named: userimageArr[indexPath.row])
        //        cell.teamerNameLabel.text = userNameArr[indexPath.row]
        //        cell.teamerRoleLabel.text = "Admin"
        
        switch indexPath.section {
        case 0:
            let cell:AddedUserCell = tableView.dequeueReusableCell(withIdentifier: "AddedUserCell") as! AddedUserCell
            //let cell = tableView.dequeueReusableCell(withIdentifier: "AddedUserCell", for: indexPath)
            cell.avatar.image = UIImage(named: userimageArr[indexPath.row])
            cell.teamerNameLabel.text = userNameArr[indexPath.row]
            cell.teamerRoleLabel.text = "Admin"
            return cell
        case 1:
            let cell:ResendSMSCell = tableView.dequeueReusableCell(withIdentifier: "ResendSMSCell") as! ResendSMSCell
            //let cell = tableView.dequeueReusableCell(withIdentifier: "AddedUserCell", for: indexPath)
            cell.phoneNumber.text = "1111 1111"
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddedUserCell", for: indexPath)
            return cell
        }
        
        //return cell
    }
    
    //    header的高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 342
        }else {
            return 0
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "\(section)"
    //    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }
    
    //    header的内容
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 342))
        
        
        let view1: UIView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 166))
        let view2: UIView = UIView(frame: CGRect(x: 0, y: 166, width: self.view.frame.size.width, height: 80))
        let view3: UIView = UIView(frame: CGRect(x: 0, y: 237, width: self.view.frame.size.width, height: 40))
        let view4: UIView = UIView(frame: CGRect(x: 0, y: 270, width: self.view.frame.size.width, height: 72))
        
        view1.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 240/255, alpha: 1.0)
        //        view1.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor
        //        view1.layer.borderWidth = 0.5
        //view1.backgroundColor = UIColor.white
        
        view2.backgroundColor = UIColor.white
        view2.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor
        view2.layer.borderWidth = 0.5
        
        view3.backgroundColor = UIColor.white
        view3.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor
        view3.layer.borderWidth = 0.5
        
        view4.backgroundColor = UIColor.white
        view4.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor
        view4.layer.borderWidth = 0.5
        //view.backgroundColor = UIColor.cyan
        
        //        set team name
        let setNameText = UITextField(frame: CGRect(x: 10, y: 10, width: self.view.frame.size.width, height: 60))
        //setNameText.delegate = self
        setNameText.placeholder = "Team Name"
        setNameText.font = UIFont(name: "Avenir-Book", size: 25)
        setNameText.backgroundColor = UIColor.white
        setNameText.clearButtonMode = UITextFieldViewMode.whileEditing
        setNameText.keyboardType = .default
        setNameText.returnKeyType = UIReturnKeyType.done
        
        
        
        
        
        //        add members
        let addMembermberLabel = UILabel(frame: CGRect(x: 25, y: 10, width: 78, height: 16))
        addMembermberLabel.font  = UIFont(name: "Avenir-Medium", size: 12)
        addMembermberLabel.textColor = UIColor.black
        addMembermberLabel.text = "Add Members"
        addMembermberLabel.backgroundColor = UIColor.white
        //setTeamNameLabel.textAlignment = .center
        
        //        x admins and y members
        let showMembermberLabel = UILabel(frame: CGRect(x: 232, y: 10, width: 131, height: 16))
        showMembermberLabel.font  = UIFont(name: "Avenir-Oblique", size: 12)
        showMembermberLabel.textColor = UIColor(red: 128/255, green: 144/255, blue: 165/255, alpha: 1.0)
        showMembermberLabel.text = "1 admin and 6 members"
        showMembermberLabel.backgroundColor = UIColor.white
        
        //        add +
        let addLabel = UILabel(frame: CGRect(x: 24, y: 27, width: 20, height: 20))
        addLabel.font  = UIFont(name: "Avenir-Medium", size: 30)
        addLabel.textColor = UIColor(red: 253/255, green: 59/255, blue: 48/255, alpha: 1.0)
        addLabel.text = "+"
        addLabel.backgroundColor = UIColor.white
        
        //   search/pick user
        let searchText = UITextField(frame: CGRect(x: 50, y: 27, width: 280, height: 27))
        //setNameText.delegate = self
        searchText.placeholder = "  "
        searchText.font = UIFont(name: "Avenir-Heavy", size: 20)
        searchText.backgroundColor = UIColor.white
        searchText.clearButtonMode = UITextFieldViewMode.whileEditing
        searchText.keyboardType = .default
        searchText.returnKeyType = UIReturnKeyType.done
        searchText.adjustsFontSizeToFitWidth=true  //当文字超出文本框宽度时，自动调整文字大小
        //searchText.delegate = self
        //searchBar?
        let searchBar = UISearchBar(frame:CGRect(x: 50, y: 27, width: 280,height: 27))
        
        //        pickPhoto()
        teamBtn.layer.cornerRadius = teamBtn.bounds.size.width / 2
        teamBtn.clipsToBounds = true
        teamBtn.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        teamBtn.backgroundColor = UIColor.white
        
        cameraBut.backgroundColor = UIColor.white
        cameraBut.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        cameraBut.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        
        if flag == true {
            
            view1.addSubview(teamBtn)
            view1.addSubview(cameraBut)
            
            view2.addSubview(setNameText)
            
            view3.addSubview(addMembermberLabel)
            view3.addSubview(showMembermberLabel)
            
            view4.addSubview(addLabel)
            view4.addSubview(searchText)
            
            
            view.addSubview(view1)
            view.addSubview(view2)
            view.addSubview(view3)
            view.addSubview(view4)
            
            
            flag = false
            return view
            
        }else {
            
            return view
            
        }
    }
    
    
}

extension CreateTeamViewController: UITableViewDelegate {
    
    //    选中行
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //    允许滑动删除
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    //        if indexPath.section == 0{
    //            //tableView.deselectRow(at: indexPath, animated: true)
    //        return (UITableViewCellEditingStyle.delete)
    //        }else {
    //            return (UITableViewCellEditingStyle.none)
    //        }
    //
    //    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return (UITableViewCellEditingStyle.none)
    }
    
    //自定义划动时delete按钮内容
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "ADMIN"
    }
    
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
        return true
        }else {
            return false
        }
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        return true
//    }
    
    
}

extension CreateTeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        teamBtn.setImage(info[UIImagePickerControllerEditedImage] as? UIImage, for: .normal)
        if let theImage = teamBtn.currentImage {
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
        teamBtn.setImage(image, for: .normal)
    }
}
