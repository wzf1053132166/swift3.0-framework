//
//  AppointSingleCell.swift
//  jew
//
//  Created by apple on 2017/1/17.
//  Copyright © 2017年 wangzhifei. All rights reserved.
//

import UIKit

class AppointSingleCell: UITableViewCell {

    var timer:Timer!
    var max:CGFloat!
    
        
    let progressBtn = RoundProgressBar.init(frame: CGRect(x: 80, y: 10, width: 100, height: 100))
  
    func setUpUI() {
        progressBtn.backgroundColor = RGBCOLOR(r: 244, 244, 244)
        progressBtn.clipsToBounds = true
        progressBtn.layer.cornerRadius = self.progressBtn.frame.width/2;
        self.contentView.addSubview(progressBtn)
        self.contentView.bringSubview(toFront: self.progressBtn)
        self.progressBtn.progress = CGFloat(0)
        
        
    }
    func setUpTime() {
        self.cancelButton()
        self.timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(improveProgress), userInfo: nil, repeats: true);
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes);
    }
    
    func improveProgress() {
        
        self.progressBtn.progress += 0.02;
        if (self.progressBtn.progress >= self.max) {
            self.cancelButton()
        }
    }
    func cancelButton() {
        
        if (self.timer != nil) {
            self.timer.invalidate();
            self.timer = nil;
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.max = 1
        self.setUpUI()
        self.setUpTime()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
