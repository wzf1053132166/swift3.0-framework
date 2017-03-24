//
//  NetWorkRequest.swift
//  jew
//
//  Created by wangzhifei on 2017/1/13.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

import Alamofire

@objc protocol NetWorkRequestDelegate:NSObjectProtocol  {
    //设置协议方法
    @objc optional func netWorkRequestSuccess(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)
    @objc optional func netWorkRequestFailed(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)
    
}

class NetWorkRequest: NSObject {

    weak var delegate:NetWorkRequestDelegate?
    static var manager:SessionManager!
    
    //MARK: 闭包回调请求
    class func requestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : [String : Any], finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        var headers: HTTPHeaders? = nil
        
        if UserVO.instance.token == nil || UserVO.instance.token == ""{
            
        }else{
            headers = [
                "Authorization": "Token " + UserVO.instance.token!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        Alamofire.request(URLString, method: type, parameters: parameters,encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess{
                let data = response.result.value
//                let data = response.value
                finishedCallback(response.result.value)
                
            }else{
                finishedCallback(response)
            }
            
        }
        
     
        
    }
    //MARK: 代理请求
    class func netWorkRequestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : NSDictionary,responseDelegate : AnyObject) {
        
        var headers: HTTPHeaders? = nil
        
        if UserVO.instance.token == nil || UserVO.instance.token == ""{
            
        }else{
            headers = [
                "Authorization": "Token " + UserVO.instance.token!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        //配置 , 通常默认即可
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        
        //设置超时时间为10S
        config.timeoutIntervalForRequest = NetworkTimeoutTime
        self.manager = SessionManager(configuration: config)
        self.manager.request(URLString, method: type, parameters: parameters as? Parameters, encoding: JSONEncoding.default,headers: headers).responseJSON { (response) in
            
            if response.result.isSuccess{
                let data = response.result.value
                 let json = data as Any
                if JSON(json).isEmpty{
                    
                    if response.response?.statusCode == nil{
                        self .successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                    }else{
                        if response.response?.statusCode == 401 {
                            
                            CommonAPI.exitSystem()
                            MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                            return
                        }
                        
                        self.successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                    }
                    
                    
                }else{
                    
                    if response.response?.statusCode == 401 {
                        
                        CommonAPI.exitSystem()
                        MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                        return
                    }
                    
                    self .successResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
                
            }else{
                let data = response.result.value
                let json = data as Any
                if JSON(json).isEmpty{
                    
                    
                    self .failedResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                }else{
                    self .failedResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
            }
            
        }
        
    }
    
    class func getNetWorkRequestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : NSDictionary,responseDelegate : AnyObject) {
        var headers: HTTPHeaders? = nil
        
        if UserVO.instance.token == nil || UserVO.instance.token == ""{
            
        }else{
            headers = [
                "Authorization": "Token " + UserVO.instance.token!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        //配置 , 通常默认即可
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        
        //设置超时时间为10S
        config.timeoutIntervalForRequest = NetworkTimeoutTime
        self.manager = SessionManager(configuration: config)
        
        self.manager.request(URLString, headers: headers).responseJSON { response in
            if response.result.isSuccess{
                let data = response.result.value
                let json = data as Any
                if JSON(json).isEmpty{
                    
                    if response.response?.statusCode == nil{
                        self .successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                    }else{
                        
                        //我们是指定401是挤掉线到登录页面，你们看着改也可以注掉
                        if response.response?.statusCode == 401 {
                            
                            CommonAPI.exitSystem()
                            MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                            return
                        }
                        
                        self.successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                    }
                    
                    
                }else{
                    
                    if response.response?.statusCode == 401 {
                        
                        CommonAPI.exitSystem()
                        MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                        return
                    }
                    
                    self .successResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
                
            }else{
                let data = response.result.value
                let json = data as Any
                if JSON(json).isEmpty{
                    
                    
                    self .failedResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                }else{
                    self .failedResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
            }
        }

        
    }
    
    class func get1NetWorkRequestData(_ type : HTTPMethod, URLString : String,nameString : String, parameters : NSDictionary,responseDelegate : AnyObject) {
        var headers: HTTPHeaders? = nil
        
        if UserVO.instance.token == nil || UserVO.instance.token == ""{
            
        }else{
            headers = [
                "Authorization": "Token " + UserVO.instance.token!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
        
        //配置 , 通常默认即可
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        
        //设置超时时间为10S
        config.timeoutIntervalForRequest = NetworkTimeoutTime
        manager = SessionManager(configuration: config)
        
        manager?.request(URLString, headers: headers).responseJSON { response in
            if response.result.isSuccess{
                let data = response.result.value
                let json = data as Any
                if JSON(json).isEmpty{
                    
                    if response.response?.statusCode == nil{
                        self .successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                    }else{
                        if response.response?.statusCode == 401 {
                            
                            CommonAPI.exitSystem()
                            MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                            return
                        }
                        
                        self.successResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                    }
                    
                    
                }else{
                    
                    if response.response?.statusCode == 401 {
                        
                        CommonAPI.exitSystem()
                        MBProgressHUD.showSuccess(JSON(json)["msg"].string)
                        return
                    }
                    
                    self .successResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
                
            }else{
                let data = response.result.value
                let json = data as Any
                if JSON(json).isEmpty{
                    
                    
                    self .failedResponseDatas(responseData: data as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:500)
                }else{
                    self .failedResponseDatas(responseData: json as AnyObject, responseDelegate: responseDelegate, requestName: nameString, parameters: parameters,statusCode:(response.response?.statusCode)!)
                }
                
                
            }
        }
        
        
    }
    
    //MARK: 请求成功代理
    class func successResponseDatas(responseData:AnyObject,responseDelegate:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)  {
        
        responseDelegate.netWorkRequestSuccess?(data: responseData, requestName: requestName, parameters: parameters, statusCode: statusCode)
        
        
    }
    //MARK: 请求失败代理
    class func failedResponseDatas(responseData:AnyObject,responseDelegate:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int)  {
        responseDelegate.netWorkRequestFailed?(data: responseData, requestName: requestName, parameters: parameters, statusCode: statusCode)
        
    }
    
    //MARK: 图片，视频等文件上传
    class func upLoadFileRequest(method : HTTPMethod , urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            //MARK：这里根据服务器给的参数自行修改
            let key = params["key"]
            let key1 = params["key1"]
            
            multipartFormData.append((key?.data(using: String.Encoding.utf8)!)!, withName: "name")
            multipartFormData.append( (key1?.data(using: String.Encoding.utf8)!)!, withName: "key1")
            
            multipartFormData.append(data[0], withName: "photo", fileName: name[0], mimeType: "image/png")
            
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlString, method: method, headers: headers) { encodingResult in
            switch encodingResult {
                
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let value = response.result.value as? [String: AnyObject]{
                        success(value)
                        let json = JSON(value)
                        DLog(json)
                        
                    }
                }
            case .failure(let encodingError):
                failture(encodingError)
            }
        }
   
    }
    
    
    
}
