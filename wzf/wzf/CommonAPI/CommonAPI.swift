//
//  CommonAPI.swift
//  jew
//
//  Created by wangzhifei on 2017/1/13.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit


class CommonAPI: NSObject {

    //获取当前的年月日 2016-06-15
    class func getDateStringWithY_M_D() -> (String){
        let date:NSDate = NSDate()
        let dateFormatter:DateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        let dateString:String = dateFormatter.string(from: date as Date)
        return dateString
    }

    //将UTC日期字符串转为本地时间字符串
    //输入的UTC日期格式2013-08-03T04:53:51+0000
//    -(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
//    {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //输入格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
//    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
//    [dateFormatter setTimeZone:localTimeZone];
//    
//    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
//    //输出格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
//    [dateFormatter release];
//    return dateString;
//    }
    class func getLocalDateFormateUTCDate(str:String) ->(String){
        let dateFormatter = DateFormatter.init()
        DLog(str)
//        ("2017-02-01T03:00:00Z")
        if str.characters.count == 18{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }else if str.characters.count == 20 {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssSZ"
        }else if str.characters.count == 23 {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        }else if str.characters.count == 25{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
        }else if str.characters.count == 27{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        }else{
            return str
        }

//        var end:String?
//        if (str as String).characters.count >= 19{
//            
//            end = str.substring(to: 19)
//            
//        }else{
//            return str as (String)
//        }
        
        let localTimeZone = NSTimeZone.local
        dateFormatter.timeZone = localTimeZone
        //        2017-02-22T08:00:00.840348Z
        let dateFormatted = dateFormatter.date(from: str)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString:String = dateFormatter.string(from: dateFormatted!)
        return dateString
        
    }
    
    class func userOtherFunc(otherFunc : ()->Void) {
        
    }
    
    static func printHelloWorld() {
        
        DLog("hello, world")
    }
  
    class func saveArchveAction(object:AnyObject) {
        
        // 归档
        let is_Success:Bool = NSKeyedArchiver.archiveRootObject(object, toFile: ContactFilePath)
        if is_Success {
            
            DLog("归档模型成功")
        }else {
            DLog("归档模型失败")
        }
    }

    
    class func getUnArchveAction()->(UserVO) {
        // 从归档中读取给数组，如果第一次读取无数据，则实例化模型
        
        // 解档方法
        NSKeyedUnarchiver.unarchiveObject(withFile: ContactFilePath)
        
        var contactArr:UserVO?
        
        DLog("从归档中提取")
        contactArr = NSKeyedUnarchiver.unarchiveObject(withFile: ContactFilePath) as? UserVO
        if(contactArr == nil){
            return UserVO.instance
        }else{
            DLog(contactArr?.username,contactArr?.password,contactArr?.loginStatus,contactArr?.telephone,contactArr?.department,contactArr?.job,contactArr?.business_card,contactArr?.address,contactArr?.id,contactArr?.token,contactArr?.user_type)
            return contactArr!
        }
      
    
    }
    
    class func exitSystem(){
//        let loginNav = BaseNavgationViewController(rootViewController:LoginViewController())
//        MyAppDelegate?.window??.rootViewController = loginNav
//        UserVO.clearAllLocalData()
//        UserVO.instance = CommonAPI.getUnArchveAction()
    }

    
}


    
