//
//  AppImageHelper.swift
//  kfb
//
//  Created by apple on 2017/2/14.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//


import UIKit


public class AppImageHelper: NSObject {


    
    //图片压缩 1000kb以下的图片控制在100kb-200kb之间
    class func compressImageSize(image:UIImage) -> NSData{
        
        var zipImageData = UIImageJPEGRepresentation(image, 1.0)!
        var originalImgSize = zipImageData.count/1024 as Int  //获取图片大小
        DLog("原始大小: \(originalImgSize)")
        
        if originalImgSize>1500 {
            
            zipImageData = UIImageJPEGRepresentation(image,0.6)!
            originalImgSize = zipImageData.count/1024 as Int
            DLog("压缩后大小: \(originalImgSize)")
        }else if originalImgSize>800 {
            
            zipImageData = UIImageJPEGRepresentation(image,0.8)!
            originalImgSize = zipImageData.count/1024 as Int
            DLog("压缩后大小: \(originalImgSize)")
        }else if originalImgSize>600 {
            
            zipImageData = UIImageJPEGRepresentation(image,0.9)!
            originalImgSize = zipImageData.count/1024 as Int
            DLog("压缩后大小: \(originalImgSize)")
        }else if originalImgSize>400 {
            
            zipImageData = UIImageJPEGRepresentation(image,0.95)!
            originalImgSize = zipImageData.count/1024 as Int
            DLog("压缩后大小: \(originalImgSize)")
        }
        
        return zipImageData as NSData
    }
    
    
    
    class func resizeImage(originalImg:UIImage) -> UIImage{
        
        //prepare constants
        let width = originalImg.size.width
        let height = originalImg.size.height
        let scale = width/height
        
        var sizeChange = CGSize()
        
        if width <= 800 && height <= 800{ //a，图片宽或者高均小于或等于800时图片尺寸保持不变，不改变图片大小
            return originalImg
        }else if width > 800 || height > 800 {//b,宽或者高大于800，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            
            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 800
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale >= 0.5 && scale <= 1 {
                
                let changedheight:CGFloat = 800
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if width > 800 && height > 800 {//宽以及高均大于800，但是图片宽高比大于2时，则宽或者高取小的等比压缩至800
                
                if scale > 2 {//高的值比较小
                    
                    let changedheight:CGFloat = 800
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }else if scale < 0.5{//宽的值比较小
                    
                    let changedWidth:CGFloat = 800
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }
            }else {//d, 宽或者高，只有一个大于800，并且宽高比超过2，不改变图片大小
                return originalImg
            }
        }
        
        UIGraphicsBeginImageContext(sizeChange)
        
        //draw resized image on Context
        originalImg.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height:sizeChange.height))
        
        //create UIImage
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImg!
        
    }
    
    
}
