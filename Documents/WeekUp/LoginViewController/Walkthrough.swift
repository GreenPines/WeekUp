//
//  Walkthrough.swift
//  WeekUp
//
//  Created by 万大千 on 2017/7/11.
//  Copyright © 2017年 万大千. All rights reserved.
//

import UIKit

class Walkthrough: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var courses = [
        ["name":"WeekUp Everyday!","pic":"ag.png"],
        ["name":"WeekUp Everyone!","pic":"bgx.png"],
        ["name":"WeekUp Everything!","pic":"cg.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(
            width: CGFloat(self.view.bounds.width) * CGFloat(self.courses.count),
            height: self.view.bounds.height
        )
        //关闭滚动条显示
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        //协议代理，在本类中处理滚动事件
        scrollView.delegate = self
        //滚动时只能停留到某一页
        scrollView.isPagingEnabled = true
        //添加页面到滚动面板里
        let size = scrollView.bounds.size
        for (seq,course) in courses.enumerated() {
            let page = UIView()
            let imageView=UIImageView(image:UIImage(named:course["pic"]!))
            page.addSubview(imageView);
            page.backgroundColor = UIColor.green
            
                let lbl = UILabel(frame: CGRect(x: 73, y: 425, width: 229, height: 31));     lbl.text = course["name"]
            lbl.textAlignment=NSTextAlignment.center
            lbl.font=UIFont.systemFont(ofSize: 23)
            lbl.textColor = UIColor.white
            page.addSubview(lbl)
            page.frame = CGRect(x: CGFloat(seq) * size.width, y: 0,
                                width: size.width, height: size.height)
            scrollView.addSubview(page)
        }
        
        //页控件属性
        pageControl.backgroundColor = UIColor.clear
        pageControl.numberOfPages = courses.count
        pageControl.currentPage = 0
        //设置页控件点击事件
        pageControl.addTarget(self, action: #selector(pageChanged(_:)),
                              for: UIControlEvents.valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //设置pageController的当前页
        pageControl.currentPage = page
    }
    
    //点击页控件时事件处理
    func pageChanged(_ sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        scrollView.scrollRectToVisible(frame, animated:true)
        
    }
 
    @IBAction func lets(_ sender: Any) {
        let controller = Signup(nibName:"Signup", bundle:nil)
        //信息界面出现的动画方式
        controller.modalTransitionStyle = .coverVertical
        //界面跳转
        self.present(controller, animated:true, completion:nil)
    }
   
    @IBAction func login(_ sender: Any) {
        let controller = Login(nibName:"Login", bundle:nil)
        //信息界面出现的动画方式
        controller.modalTransitionStyle = .coverVertical
        //界面跳转
        self.present(controller, animated:true, completion:nil)

    }
}
