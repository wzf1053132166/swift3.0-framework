//
//  UserVO.swift
//  kfb
//
//  Created by apple on 2017/2/15.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit


class UserVO: NSObject,NSCoding {

    
    
    
    internal static var instance = UserVO()
//    //必须保证init方法的私有性，只有这样，才能保证单例是真正唯一的，避免外部对象通过访问init方法创建单例类的其他实例。由于Swift中的所有对象都是由公共的初始化方法创建的，我们需要重写自己的init方法，并设置其为私有的。
//    override init(){
//        DLog("create 单例")
//        
//    }
//    
//    
    
    var loginStatus:String?
    var username:String?
    var password:String?
    var telephone:String?
    var department:String?
    var job:String?
    var business_card:String?
    var address:String?
    var token:String?
    var id:String?
    var user_type:String?
    
    private override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        
        username = (aDecoder.decodeObject(forKey: "username") as? NSString) as? String
        password = (aDecoder.decodeObject(forKey: "password") as? NSString) as? String
        loginStatus = (aDecoder.decodeObject(forKey: "loginStatus") as? NSString) as? String
        telephone = (aDecoder.decodeObject(forKey: "telephone") as? NSString) as? String
        department = (aDecoder.decodeObject(forKey: "department") as? NSString) as? String
        job = (aDecoder.decodeObject(forKey: "job") as? NSString) as? String
        business_card = (aDecoder.decodeObject(forKey: "business_card") as? NSString) as? String
        address = (aDecoder.decodeObject(forKey: "address") as? NSString) as? String
        token = (aDecoder.decodeObject(forKey: "token") as? NSString) as? String
        id = (aDecoder.decodeObject(forKey: "id") as? NSString) as? String
        user_type = (aDecoder.decodeObject(forKey: "user_type") as? NSString) as? String
    }
    
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(loginStatus, forKey: "loginStatus")
        aCoder.encode(telephone, forKey: "telephone")
        aCoder.encode(department, forKey: "department")
        aCoder.encode(job, forKey: "job")
        aCoder.encode(business_card, forKey: "business_card")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(user_type, forKey: "user_type")
        
        
    }
    
    /* methods */
    
    class func initUserModelWithDic(dic:Any) -> UserVO {
        
        let userModel: UserVO = UserVO.init()
        let json = JSON(dic as Any)
        
        userModel.username = json["username"].string
        userModel.password = json["password"].string
        userModel.loginStatus = json["loginStatus"].string
        userModel.telephone = json["telephone"].string
        userModel.department = json["department"].string
        userModel.job = json["job"].string
        userModel.business_card = json["business_card"].string
        userModel.address = json["address"].string
        userModel.token = json["token"].string
        userModel.id = json["id"].string
        userModel.user_type = json["user_type"].string
        
        
        return userModel
    }
    
    func insertData(dic:[String:Any]) {
        
    }
    
    class func clearAllLocalData(){
        let dic = NSMutableDictionary()
        dic["username"] = ""
        dic["password"] = ""
        dic["loginStatus"] = "false"
        dic["telephone"] = ""
        dic["department"] = ""
        dic["job"] = ""
        dic["business_card"] = ""
        dic["address"] = ""
        dic["token"] = ""
        dic["id"] = ""
        dic["user_type"] = ""
        
        let user = UserVO.initUserModelWithDic(dic: dic)
        CommonAPI.saveArchveAction(object: user)
    }
    
   
}


