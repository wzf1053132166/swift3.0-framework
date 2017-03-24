//
//  SendSingleViewController.swift
//  jew
//
//  Created by apple on 2017/2/7.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit
import MJRefresh

class SendSingleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let loginName = "loginName"
    let exitName = "exitName"
    
    
    var tableView:UITableView?
    var dataArray:NSMutableArray?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUserInterface()
        self.accessToServerForGetLogin()
    }
    
    
    
    func initializeUserData(){
        
        
    }
    
    func initializeUserInterface(){
        
        
        
        self.tableView = UITableView(frame:CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-kTabBarH-NAVIGATION_BAR_HEIGHT), style:.plain)
        
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView?.backgroundColor = BACKGROUDNDCOLOR
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.register(UINib(nibName: "AppointSingleCell", bundle: nil), forCellReuseIdentifier: HomePageCellIdentifier)
        self.view.addSubview(self.tableView!)
        self.configureRefresh()
    }
    
    //设置下拉和上啦刷新
    func configureRefresh(){
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewData))
        header?.stateLabel.font = FONT_SIZE(13)
        header?.lastUpdatedTimeLabel.font = FONT_SIZE(12)
        self.tableView?.mj_header = header
        self.tableView?.mj_header.beginRefreshing()
        
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(addNewData))
        footer?.stateLabel.font = FONT_SIZE(13)
        self.tableView?.mj_footer = footer
        
    }
    
    func loadNewData(){
        
        self.tableView?.mj_header.endRefreshing()
        
    }
    
    func addNewData(){
        
        self.tableView?.mj_footer.endRefreshing()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
        //return dataArray!.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 169;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:AppointSingleCell = tableView .dequeueReusableCell(withIdentifier: HomePageCellIdentifier, for: indexPath as IndexPath) as! AppointSingleCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.progressBtn.progress = 0;
        if indexPath.row == 0{
            cell.max = 0.9
        }
        if indexPath.row == 1{
            cell.max = 0.8
        }
        if indexPath.row == 2{
            cell.max = 1
        }
        if indexPath.row == 3{
            cell.max = 0.9
        }
        cell.setUpTime()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
    }


    func accessToServerForGetLogin(){
        
        
        let parameters:NSDictionary = [
            "menu": "土豆",
            "pn":  1,
            "rn": "10",
            "key": "2ba215a3f83b4b898d0f6fdca4e16c7c",
            ]
        
        
        //MARK: 代理请求
        NetWorkRequest.netWorkRequestData(.post, URLString: kBaseUrl, nameString: loginName, parameters: parameters, responseDelegate: self)
        
        
    }
    
    
    //MARK:实现网络请求协议中的方法
    internal func netWorkRequestSuccess(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int){
        if requestName == loginName{
            DLog("\(data):(\(requestName):(\(parameters):(\(statusCode))")
        }else if (requestName == exitName){
            
        }
        
    }
    
    internal func netWorkRequestFailed(data:AnyObject,requestName:String,parameters:NSDictionary,statusCode:Int){
        DLog("\(data):(\(requestName):(\(parameters):(\(statusCode))")
    }
    


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
