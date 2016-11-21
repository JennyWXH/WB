//
//  TitleButton.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/18.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(named:"navigationbar_arrow_down"), for: UIControlState())
        setImage(UIImage(named:"navigationbar_arrow_up"), for: UIControlState.selected)
        setTitleColor(UIColor.darkGray, for: UIControlState())
        sizeToFit()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        //会调用两次
//        titleLabel?.frame.offsetBy(dx: -imageView!.bounds.width * 0.5, dy: 0)
//        imageView?.frame.offsetBy(dx: titleLabel!.bounds.width * 0.5, dy: 0)
        
        //
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
        
    }
}
