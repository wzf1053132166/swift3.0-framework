//
//  PageManagerVC.swift
//  LXFFM_Demo
//
//  Created by Rainy on 2016/12/2.
//  Copyright © 2016年 Rainy. All rights reserved.
//

import UIKit

protocol PageManagerVC_Delegate:NSObjectProtocol {
    
    func PageManagerDidFinishSelectedVC(indexOfVC:NSInteger)
}

class PageManagerVC: UIViewController {

    //代理
    weak var delegate:PageManagerVC_Delegate?
    //控制器数组
    fileprivate var childControllerS:[UIViewController] = [UIViewController]()
    //父控制器
    fileprivate var superController:UIViewController!
    //分页控制器
    fileprivate var pageVC:UIPageViewController!
    
    
    //初始化
    init(superController:UIViewController,childControllerS:[UIViewController]){
        
        super.init(nibName: nil, bundle: nil)
        
        self.superController = superController
        self.childControllerS = childControllerS
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        // Do any additional setup after loading the view.
    }

}
extension PageManagerVC{
    
    //设置分页控制器及视图
    fileprivate func setUpUI(){
        if childControllerS.count == 0 {return}
        let temp_pageVC = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        temp_pageVC.delegate = self
        temp_pageVC.dataSource = self
        temp_pageVC.setViewControllers([childControllerS.first!], direction: .forward, animated: false, completion: nil)
        temp_pageVC.view.frame = self.view.frame
        pageVC = temp_pageVC
        self.view.addSubview(temp_pageVC.view)
    }
}

extension PageManagerVC{
    //设置当前显示控制器
    func setCurrentVCWithIndex(_ index:NSInteger) {
        
        if index < 0 || index > childControllerS.count - 1 {
            return
        }
        pageVC.setViewControllers([childControllerS[index]], direction: .forward, animated: false, completion: nil)
    }
    
}
//pageViewControllerDelegate、DataSource
extension PageManagerVC:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    //设置上一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = childControllerS.index(of: viewController) else {return nil}
        if index == 0 || index == NSNotFound {return nil}
        return childControllerS[index - 1]
    }
    //设置下一个控制器
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = childControllerS.index(of: viewController)else{return nil}
        if index == NSNotFound || index == childControllerS.count - 1{return nil}
        return childControllerS[index + 1]
    }
    //设置控制器数量
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return childControllerS.count
    }
    //当控制器完成显示后调用
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let temp_vc = pageViewController.viewControllers?[0] else {return}
        let index = childControllerS.index(of: temp_vc)!
        self.delegate?.PageManagerDidFinishSelectedVC(indexOfVC: index)
    }
    
    
}





















