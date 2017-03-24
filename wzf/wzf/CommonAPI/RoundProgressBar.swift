//
//  CommonAPI.swift
//  jew
//
//  Created by wangzhifei on 2017/1/13.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class RoundProgressBar: UIButton {

    //零时数据存储
    private var currentProgress :CGFloat = 0.0
    //设置绘图线宽
    let lineWith :CGFloat = 0.0
    let excircleLineWith :CGFloat = 0.0
    
    
    var progress :CGFloat = 0.0 {
        //willSet观察属性值的变化
        willSet (newValue){
            
          //获取当前的进度值
            currentProgress=newValue
            self.setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        
        
//        arcCenter 圆心坐标
//         radius　　　半径
//         startAngle　起始角度
//         endAngle　　　结束角度
//         clockwise　　　true:顺时针/false：逆时针
        
        let size = rect.size
        
        let arcCenter = CGPoint(x: size.width*0.5, y: size.height*0.5)
        var radius = min(size.width, size.height)*0.5
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = currentProgress*2*CGFloat(M_PI) + startAngle
        radius -= self.excircleLineWith
        
        let excircle = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(0), endAngle:CGFloat( 2*M_PI), clockwise: true)
        
        excircle.lineWidth = excircleLineWith
        UIColor.white.set()
        excircle.lineCapStyle = CGLineCap.round//设置线样式
        excircle.stroke()
        
      //  UIColor.whiteColor().set()
        
         radius -= self.excircleLineWith*2
        //
        
       
        
        
        let path = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//
        path.lineWidth = self.lineWith
        
//        path.lineWidth = 13//设置线宽
        path.lineCapStyle = CGLineCap.round//设置线样式
      
        RGBCOLOR(r: 143, 206, 253).set()

        //绘制路径
//        //镂空型
//        path.stroke()
        
        //填充型
        path.addLine(to: arcCenter)
        path.fill()
        
        
        let endAngle1 = 2*CGFloat(M_PI) + startAngle
        radius += 15
        
        let path1 = UIBezierPath(arcCenter: arcCenter, radius: 40, startAngle: startAngle, endAngle: endAngle1, clockwise: true)
        
        path1.lineWidth = 10
        
//                path.lineWidth = 5//设置线宽
        path1.lineCapStyle = CGLineCap.round//设置线样式
        
        RGBCOLOR(r: 56, 146, 239).set()
        path1.fill()
        
    }
    
    
}
