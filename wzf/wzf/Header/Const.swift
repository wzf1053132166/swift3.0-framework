//
//  Const.swift
//  jew
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import Foundation

import UIKit


#if true  //true外网 false内网

let kBaseUrl:String = "http://www.baidu.com"
let kBasePhotoUrl:String = "http://www.baidu.com"

#else

    
let kBaseUrl:String = "http://www.baidu.com"
let kBasePhotoUrl:String = "http://www.baidu.com"

#endif

let NetworkTimeoutTime:Double = 10

let NAVIGATION_BAR_HEIGHT:CGFloat = 64
let MyUserDefaults = UserDefaults.standard
let kDeviceVersion = Float(UIDevice.current.systemVersion)
let kTabBarH:CGFloat = 48

let TitleLabelY:CGFloat = 28
let BackButtonY:CGFloat = 26
let kThemeColor = UIColor(red: 63.0/255.0, green: 67.0/255.0, blue: 76.0/255.0, alpha: 1.0)
let STATUS_BAR_HEIGHT:CGFloat = 20
let BACKGROUDNDCOLOR = UIColor(red: 236/255.0, green: 235/255.0, blue: 243/255.0, alpha: 1.0)
let GREENITEMCOLOR = RGBCOLOR(r: 27, 183, 110)


let ContactFilePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0].appending("/contacts.data")


//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
//屏幕高度
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let MyAppDelegate = UIApplication.shared.delegate


// MARK:- 变量


let kMyUserVOKey:String = "kMyUserVOKey"


// MARK:- 自定义打印方法
func DLog<T>(_ message : T) {
    
    #if true
        
        print("\(message)")
        
    #endif
}

//MARK: 不透明颜色
func RGBCOLOR(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor
{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}



//MARK: -颜色方法
func RGBA (_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/// 系统普通字体
var FONT_SIZE: (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size);
}

/// 系统加粗字体
var FONT_BOLDSIZE: (CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: size);
}

//MARK: IOS 8以上
func IS_IOS8() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0 }


//MARK: Cell Identifier

let HomePageCellIdentifier:String = "HomePageCellIdentifier"



//MARK: Notification

let TaskNotifaction:String = "TaskNotifaction"


//MARK: URL

//用户登录
let API_LOGIN_PATH:String = kBaseUrl+"tokens/"












