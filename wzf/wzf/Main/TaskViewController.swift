//
//  TaskViewController.swift
//  wzf
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit
import SnapKit


class TaskViewController: BaseViewController {

    lazy var subviewTitles:[String] = {
        
        let array = ["待派单(0)", "催收中(11)","结算中(123)","已结算(99)"]
        return array
        
    }()
        
    lazy var VCManager:VCManagerView = {
        
        let manager = VCManagerView(frame:CGRect.init(x: 0, y: NAVIGATION_BAR_HEIGHT, width: SCREEN_WIDTH, height: 44))
        manager.delegate = self
        self.view.addSubview(manager)
        
        return manager
        
    }()
    lazy var pageMagager:PageManagerVC = {
        
        let manager = PageManagerVC.init(superController: self, childControllerS: [SendSingleViewController(),CollectionViewController(),SettlementViewController(),CompeleteViewController()])
        manager.delegate = self
        self.view.addSubview(manager.view)
        return manager
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backButton.isHidden = true
        self.titleLabel.text = "我的委单"
        //        self.initializeUserInterface()
        self.view.bringSubview(toFront: self.headerView)
        VCManager.title_font = UIFont.systemFont(ofSize: 14)
        VCManager.sliderWidthType = .ButtonWidth
        VCManager.title_array = subviewTitles
        VCManager.selectedColor = RGBCOLOR(r: 43, 148, 239)
        setConstraint()
        
        
    }
    
    fileprivate func setConstraint(){
        
        
        pageMagager.view.snp.makeConstraints { (make) in
            
            make.top.equalTo(VCManager.snp.bottom)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-kTabBarH)
        }
        
    }
    
    
    
    func initializeUserData(){
        
        
    }
    
    func initializeUserInterface(){
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}



extension TaskViewController:VCManagerDelegate,PageManagerVC_Delegate{
    
    
    func VCManagerDidSelected(_ VCManager: VCManagerView, index: NSInteger, title: String) {
        
        pageMagager.setCurrentVCWithIndex(index)
        let range = NSMakeRange(0, 4)
        let style = NSMutableParagraphStyle()
        for i in 0..<subviewTitles.count
        {
            
            let attributeString = NSMutableAttributedString(string: subviewTitles[i])
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black,range: NSMakeRange(0, subviewTitles[i].characters.count))
            
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
            VCManager.BT_array[i].setAttributedTitle(attributeString, for: UIControlState.normal)
        }
        
        let attribute = NSMutableAttributedString(string: subviewTitles[index])
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 43/255.0, green: 148/255.0, blue: 239/255.0, alpha: 1.0),range: NSMakeRange(0, 3))
        
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.red,range: NSMakeRange(3, subviewTitles[index].characters.count-3))
        attribute.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        VCManager.BT_array[index].setAttributedTitle(attribute, for: UIControlState.normal)
        
        
    }
    func PageManagerDidFinishSelectedVC(indexOfVC: NSInteger) {
        VCManager.reloadSelectedBT(at: indexOfVC)
        let range = NSMakeRange(0, 4)
        let style = NSMutableParagraphStyle()
        for i in 0..<subviewTitles.count
        {
            let attributeString = NSMutableAttributedString(string: subviewTitles[i])
            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black,range: NSMakeRange(0, subviewTitles[i].characters.count))
            
            attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
            VCManager.BT_array[i].setAttributedTitle(attributeString, for: UIControlState.normal)
        }
        
        let attribute = NSMutableAttributedString(string: subviewTitles[indexOfVC])
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 43/255.0, green: 148/255.0, blue: 239/255.0, alpha: 1.0),range: NSMakeRange(0, 3))
        
        attribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.red,range: NSMakeRange(3, subviewTitles[indexOfVC].characters.count-3))
        attribute.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        VCManager.BT_array[indexOfVC].setAttributedTitle(attribute, for: UIControlState.normal)
    }
    
}
