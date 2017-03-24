//
//  MineViewController.swift
//  wzf
//
//  Created by apple on 2017/3/6.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imagePhoto: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backButton.isHidden = true
        self.titleLabel.text = "主公莫慌"
    }

    @IBAction func openPhotoWithTag(_ sender: Any) {
        self.getPhoto()
    }
    func getPhoto(){
        
        let alertSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "相机", "相册")
        alertSheet.show(in: self.view)
        
        
        
    }
    
    // 代理方法
    // MARK: UIActionSheetDelegate
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        if buttonIndex == 0
        {
            
        }
        else if buttonIndex == 1
        {
            //相机
            self.openCamera()
        }
        else if buttonIndex == 2
        {
            //相册
            self.openAlbum()
        }
    }
    
    //打开相册
    func openAlbum(){
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            //            picker.allowsEditing = editSwitch.on
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            //创建图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //设置来源
            picker.sourceType = UIImagePickerControllerSourceType.camera
            //允许编辑
            picker.allowsEditing = true
            //打开相机
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
        }else{
            debugPrint("找不到相机")
        }
    }
    
    //选择图片成功后代理
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        //查看info对象
        DLog(info)
        //获取选择的原图
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let tempA = AppImageHelper.resizeImage(originalImg: image)
        
        let endImage = AppImageHelper.compressImageSize(image: tempA)
        
        self.imagePhoto.image = UIImage(data: endImage as Data)
        
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
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
