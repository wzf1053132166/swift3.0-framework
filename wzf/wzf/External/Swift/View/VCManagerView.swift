//
//  VCManagerView.swift
//  LXFFM_Demo
//
//  Created by Rainy on 2016/12/1.
//  Copyright © 2016年 Rainy. All rights reserved.
//


import UIKit

// 屏幕宽度
let kScreenH = UIScreen.main.bounds.height
// 屏幕高度
let kScreenW = UIScreen.main.bounds.width
// RGB颜色
var kRGB:(CGFloat,CGFloat,CGFloat,CGFloat) -> UIColor = {R,G,B,A in
    return UIColor(red: R/255, green: G/255, blue: B/255, alpha: A)
    
}



enum sliderWidthEnum:NSInteger{
    case ButtonWidth = 1
    case ButtonTitleWidth = 2
}

protocol VCManagerDelegate:NSObjectProtocol {
    
    func VCManagerDidSelected(_ VCManager:VCManagerView,index:NSInteger,title:String)
}

class VCManagerView: UIView {
    
    //点击时颜色
    var selectedColor = UIColor(red: 0.96, green: 0.39, blue: 0.26, alpha: 1.0){
        didSet{
            
            reloadBT_Colors()

            
        }
        
    }
    //非点击时颜色
    var normalColor = UIColor(red: 0.38, green: 0.39, blue: 0.40, alpha: 1.0){
        didSet{
            
            reloadBT_Colors()
            
        }
    }
    //按钮数组
    var BT_array:[UIButton] = [UIButton]()
    //当前的按钮
    var selected_BT:UIButton!
    //其他的按钮
    var other_BT:UIButton!
    //按钮字体
    var title_font:UIFont?
    //滑块的宽度1.跟按钮宽度一样2.跟按钮title宽度一样，默认2
    var sliderWidthType:sliderWidthEnum = .ButtonTitleWidth
    //点击按钮的代理回调
    weak var delegate: VCManagerDelegate?
    //按钮title数组
    var title_array:[String] = []{
        
        didSet{
            
            setBTs()
        }
        
    }
    //按钮的宽度
    fileprivate var kBT_W:CGFloat?{
        
        get{
            
            if self.title_array.count >= 5{
                
                return kScreenW / 5
            }else{
                
                return kScreenW / CGFloat(self.title_array.count)
            }
        }
    }
    //滑动视图
    fileprivate lazy var scroView:UIScrollView = {
       
        let scro:UIScrollView = UIScrollView.init(frame: self.bounds)
        scro.showsHorizontalScrollIndicator = false
        scro.contentSize = CGSize.init(width: self.kBT_W! * CGFloat(self.title_array.count), height: self.height)
        scro.delegate = self
        
        self.addSubview(scro)
        return scro
        
    }()
    //滑块视图
    fileprivate lazy var sliderView:UIView = {
        
        let slider = UIView.init()
        self.addSubview(slider)
        self.bringSubview(toFront: slider)
        slider.layer.cornerRadius = 1
        slider.layer.masksToBounds = true
        
        return slider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.white
    }

}
extension VCManagerView{
    
    //通过titles创建所有按钮
    fileprivate func setBTs(){
        
        for index in 0..<title_array.count {
            
            let title = title_array[index]
            let bt = UIButton.init(type: .custom)
            let attributeString = NSMutableAttributedString(string: title)
            let range = NSMakeRange(0, title_array.count)
            
            if index == 0 {
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 43/255.0, green: 148/255.0, blue: 239/255.0, alpha: 1.0),range: NSMakeRange(0, 3))
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red,range: NSMakeRange(3, title.characters.count-3))
                let style = NSMutableParagraphStyle()
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
                
                bt.setAttributedTitle(attributeString, for: UIControlState.normal)
            }else {
                
                attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.black,range: NSMakeRange(0, title.characters.count))
                let style = NSMutableParagraphStyle()
                attributeString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
                
                bt.setAttributedTitle(attributeString, for: UIControlState.normal)
            }
            
//            attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue,
//                                         range: NSMakeRange(0, 3))
//            bt.setTitle(title, for: .normal)
//            bt.setTitleColor(normalColor, for: .normal)
//            bt.setTitleColor(selectedColor, for: .selected)
//            bt.setTitleColor(selectedColor, for: .highlighted)
            bt.frame = CGRect.init(x: CGFloat(index) * self.kBT_W!, y: 0, width: self.kBT_W!, height: self.height)
            if title_font != nil {
                bt.titleLabel?.font = title_font!
            }else
            {
                bt.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
            bt.adjustsImageWhenDisabled = false
            bt.adjustsImageWhenHighlighted = false
            
            bt.addTarget(self, action: #selector(subBT_Click(_ :)), for: .touchUpInside)
            
            self.BT_array.append(bt)
            self.scroView.addSubview(bt)
            
        }
        guard let firstBt = BT_array.first else {
            return
        }
        sliderView.backgroundColor = self.selectedColor
        sliderView.y = firstBt.height - 2
        selectorBT_beFirst(firstBt, true)
        
    }
    //按钮的点击事件代理部分
    @objc fileprivate func subBT_Click(_ bt: UIButton){
        
        if bt == selected_BT {
            return
        }
        delegate?.VCManagerDidSelected(self, index: BT_array.index(of: bt)!, title: (bt.titleLabel?.text)!)
        selectorBT_beFirst(bt, false)
    }
    //按钮点击事件UI部分
    fileprivate func selectorBT_beFirst(_ bt : UIButton, _ beFirst:Bool){
        
        self.selected_BT = bt;
        bt.isSelected = true
        otherBTset(bt)
        
        var offset = bt.centerX - self.width*0.5
        
        let max = scroView.contentSize.width - self.width
        
        if offset < 0 {
            
            offset = 0
        }
        if offset > max {
            offset = max
        }
        if scroView.contentSize.width < scroView.width {
            offset = 0
        }
        let rect = selected_BT.convert(self.frame, to: nil)
        var width:CGFloat?
        
        if sliderWidthType == .ButtonTitleWidth {
            
            width = (bt.titleLabel?.text)!.getTextSize(font: (bt.titleLabel?.font)!, size: bt.size).width
            
        }else
        {
            width = bt.width
        }
        
        if beFirst {
            
            self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
        }else{
            
            UIView.animate(withDuration: 0.2, animations: {() -> Void in
                
                self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
                self.scroView.contentOffset = CGPoint.init(x: offset, y: 0)
                
            }){finishit -> Void in
                
            }
        }
    }
    //选择指定按钮
    func reloadSelectedBT(at index:NSInteger) {
        
        if index < 0 || index > BT_array.count - 1 {
            return
        }
        let bt = BT_array[index]
        selectorBT_beFirst(bt, false)
        
    }
    //将未选择的按钮刷新着色
    fileprivate func otherBTset(_ bt : UIButton) {
        
        for temp_bt in BT_array {
            
            if temp_bt == bt {
                continue
            }
            temp_bt.isSelected = false
        }
        
    }
    //刷新颜色
    fileprivate func reloadBT_Colors(){
        
        for item in BT_array {
            
            item.setTitleColor(normalColor, for: .normal)
            item.setTitleColor(selectedColor, for: .selected)
            item.setTitleColor(selectedColor, for: .highlighted)
        }
        guard let firstBt = BT_array.first else {
            return
        }
        firstBt.isSelected = true
        sliderView.backgroundColor = self.selectedColor
    }


}
extension VCManagerView : UIScrollViewDelegate{
    
    //滑动视图代理
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = selected_BT.convert(self.frame, to: nil)
        var width:CGFloat?
        
        if sliderWidthType == .ButtonTitleWidth {
            
            width = (self.selected_BT.titleLabel?.text)!.getTextSize(font: (self.selected_BT.titleLabel?.font)!, size: self.selected_BT.size).width
            
        }else
        {
            width = self.selected_BT.width
        }

        UIView.animate(withDuration: 0.2, animations: {() -> Void in
        
            self.sliderView.frame = CGRect.init(x: rect.origin.x + (self.kBT_W! - width!)/2, y: self.sliderView.y, width: width!, height: 2)
            
        }){finished -> Void in
        
            
        }
    }
}
