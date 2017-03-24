//
//  BaseViewController.swift
//  jew
//
//  Created by wangzhifei on 2017/1/17.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    var headerView: UIView! = UIView.init()
    var headerLine: UIView! = UIView.init()
    var titleLabel: UILabel! = UILabel.init()
    var backButton: UIButton! = UIButton.init()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BACKGROUDNDCOLOR
        
        
        let width = SCREEN_WIDTH<SCREEN_HEIGHT ? SCREEN_WIDTH : SCREEN_HEIGHT
        let height = SCREEN_HEIGHT<SCREEN_WIDTH ? SCREEN_HEIGHT : SCREEN_WIDTH
        self.view.frame = CGRect(x:0, y:0, width:width, height:height)
        
        //header view
        self.headerView.frame = CGRect(x:0, y:0, width:width, height:NAVIGATION_BAR_HEIGHT)
        self.headerView.backgroundColor = GREENITEMCOLOR
        headerView.isUserInteractionEnabled = true
        headerView.clipsToBounds = true
        self.view.addSubview(self.headerView)
        
        self.headerLine.frame = CGRect(x:0, y:NAVIGATION_BAR_HEIGHT-0.5, width:width, height:0.5)
        self.headerLine.backgroundColor = UIColor.black
        self.headerLine.alpha = 0.3
        self.headerView.addSubview(self.headerLine)

        //header title
        self.titleLabel.frame = CGRect(x:50, y:TitleLabelY, width:width-100, height:24)
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.isUserInteractionEnabled = true
        self.titleLabel.font = FONT_SIZE(17)
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.headerView.addSubview(self.titleLabel)

        
        self.backButton.frame = CGRect(x:0, y:BackButtonY, width:100, height:40)
        self.backButton.setImage(UIImage.init(named: "back"), for: UIControlState.normal)
        self.backButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.backButton.imageEdgeInsets = UIEdgeInsetsMake(-10, -70, 0, 0)
        self.backButton.addTarget(self,action:#selector(backAction(sender:)),for:.touchUpInside)
        self.headerView.addSubview(self.backButton)
        
        
  
        
    }
    func backAction(sender:UIButton!){
        self.navigationController!.popViewController(animated: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }

    //使用继承xib时，其他viewcontroller需要添加这些代码
    //    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //
    //    }
    //    convenience init() {
    //        let nibNameOrNil = String?("BaseViewController")
    //
    //        self.init(nibName: nibNameOrNil, bundle: nil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
