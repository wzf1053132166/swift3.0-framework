//
//  BaseNavgationViewController.swift
//  jew
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class BaseNavgationViewController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let textAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 18),NSForegroundColorAttributeName:UIColor.white]
//        
//        UINavigationBar.appearance().titleTextAttributes = textAttributes
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().barTintColor = kThemeColor
//        UINavigationBar.appearance().isTranslucent = true

        self.navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if(self.viewControllers.count>0){
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
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
