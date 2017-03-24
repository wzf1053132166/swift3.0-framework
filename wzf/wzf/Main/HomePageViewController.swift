//
//  HomePageViewController.swift
//  wzf
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController {

    @IBOutlet weak var screenButton: UIButton!
    var screen:ScreenViewController = ScreenViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.backButton.isHidden = true
        self.titleLabel.text = "主公莫慌"
        
        
        self.view.bringSubview(toFront: self.headerView)
        
        screen.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        //添加子控制器
        self.tabBarController?.addChildViewController(screen)
        self.tabBarController?.view?.addSubview(screen.view)
        self.view.bringSubview(toFront: screenButton)

    }

    
    @IBAction func nextWithTag(_ sender: Any) {
        let next = NextViewController();
        next.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @IBAction func rightVCWithTag(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.screen.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        })

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
