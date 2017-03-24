//
//  TabBarViewController.swift
//  jew
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var homePageVC = HomePageViewController()
    var taskVC = TaskViewController()
    var mineVC = MineViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = RGBCOLOR(r: 27, 187, 110)
        self.setupAllChildViewControllers()
    }
    
    func setupAllChildViewControllers(){
        
        let homePageNav = BaseNavgationViewController(rootViewController:homePageVC)
        let homePageItem = UITabBarItem(title: "首页", image: UIImage(named: "home-normal"), selectedImage: UIImage(named: "home-selected"))
        homePageNav.tabBarItem = homePageItem
        
        let taskNav = BaseNavgationViewController(rootViewController:taskVC)
        let taskItem = UITabBarItem(title: "任务", image: UIImage(named: "task-normal"), selectedImage: UIImage(named: "task-selected"))
        taskNav.tabBarItem = taskItem;
        
        
        let mineNav = BaseNavgationViewController(rootViewController: mineVC)
        let mineItem = UITabBarItem(title: "我的", image: UIImage(named: "personal_normal"), selectedImage: UIImage(named: "personal_selected"))
        mineVC.tabBarItem = mineItem;
        
        self.viewControllers = [homePageNav,taskNav,mineNav];
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
