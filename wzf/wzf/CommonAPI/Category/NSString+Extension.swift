//
//  NSString+Extension.swift
//  LXFFM
//
//  Created by Rainy on 2016/11/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    func getTextSize(font:UIFont,size:CGSize) -> CGSize {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size;
    }
    func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        //        println("rect:\(rect)");
        return rect;
        
    }
}
