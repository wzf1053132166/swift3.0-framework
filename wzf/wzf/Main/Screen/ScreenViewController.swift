//
//  ScreenViewController.swift
//  jew
//
//  Created by apple on 2017/1/18.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeUserInterface()
    }

    
    func initializeUserData(){
        
        
    }

    func initializeUserInterface(){

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewPan))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //移动手势
    func viewPan(sender:UIPanGestureRecognizer)
    {
        let translation : CGPoint = sender.translation(in: self.view)
        
        if (sender.state == UIGestureRecognizerState.began) {
            if (translation.x<=0) {
                return
            }
        }else if (sender.state == UIGestureRecognizerState.changed) {
            if (translation.x<=0) {
                self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                return
            }
            
            self.view.frame = CGRect(x: translation.x, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            
            
        }else if (sender.state == UIGestureRecognizerState.ended) {

            if (translation.x>100) {
                UIView.animate(withDuration: 0.3, animations: {
                     self.view.frame = CGRect(x: SCREEN_WIDTH, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                }, completion: { (Bool) in
                    
                })

            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
                })
                
            }
            
            
        }

        
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
