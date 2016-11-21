//
//  VistorView.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/17.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

//Swift中如何定义协议:必须遵守NSObjectProtocol
protocol VistorViewDelegate:NSObjectProtocol{
    //登录回调
    func loginBtnWillClick()
    //注册回调
    func registerBtnWillClick()
}

class VistorView: UIView {
    
    //定义属性保存代理对象
    //加上weak 避免循环引用
    weak var delegate:VistorViewDelegate?
    
    func setUpLoginView(isHome:Bool,imageName:String,message:String) {
        //如果不是首页就隐藏转盘
        iconView.isHidden = !isHome
        //修改中间图片
        homeIcon.image = UIImage(named:imageName)
        //修改messagelabel
        messageLabel.text = message
        
        if isHome {
            startAnimation()
        }
    }
    
    func loginBtnClick() {
        print(#function)
        delegate?.loginBtnWillClick()
    }
    
    func registerBtnClick() {
        print(#function)
        delegate?.registerBtnWillClick()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //添加和布局子控件
        
        self.addSubview(iconView)
        self.addSubview(maskBGView)
        self.addSubview(homeIcon)
        self.addSubview(messageLabel)
        self.addSubview(loginBtn)
        self.addSubview(registerBtn)
        //布局子控件
        //1、设置背景
        iconView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        //2、设置小房子
        homeIcon.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        //3、设置文本
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil)
        //“哪个控件”的“什么属性”“等于”“另外一个控件”的“什么属性”乘以“多少”加上“多少”
        let widthCons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: 224)
        addConstraint(widthCons)
        //4、设置按钮
        registerBtn.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width:100,height:30), offset: CGPoint(x:0,y:20))
        loginBtn.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSize(width:100,height:30), offset: CGPoint(x:0,y:20))
        //5、设置蒙版
        maskBGView.xmg_Fill(referView: self)
    }
    
    //swift推荐我们自定义一个控件，要么用纯代码，要么就要xib
    required init?(coder aDecoder: NSCoder) {
        //如果通过xib/board创建该类，那么就会崩溃
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -内部控制方法
    private func startAnimation(){
        //创建动画
        let anim = CABasicAnimation(keyPath:"transform.rotation")
        //设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        //该属性默认为yes，动画完成移除
        anim.isRemovedOnCompletion = false
        //将动画添加到图层上
        iconView.layer.add(anim, forKey: nil)
    }
    
    private lazy var iconView:UIImageView = { () -> UIImageView in
        let iv = UIImageView(image:UIImage(named:"visitordiscover_feed_image_smallicon"))
        return iv
    }()
    
    private lazy var maskBGView:UIImageView = { () -> UIImageView in
        let iv = UIImageView(image:UIImage(named:"visitordiscover_feed_mask_smallicon"))
        return iv
    }()
    
    private lazy var homeIcon:UIImageView = { () -> UIImageView in
        let iv = UIImageView(image:UIImage(named:"visitordiscover_feed_image_house"))
        return iv
    }()
    
    private lazy var messageLabel:UILabel = { () -> UILabel in
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = UIColor.darkGray
        lab.font = UIFont.systemFont(ofSize:13)
        lab.text = "先试试添加些文字上去"
        return lab
    }()
    
    private lazy var loginBtn:UIButton = { () -> UIButton in
        let btn = UIButton()
        btn.setTitle("登录", for: UIControlState())
        btn.setTitleColor(UIColor.darkGray, for: UIControlState())
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState())
        btn.addTarget(self, action: #selector(loginBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    private lazy var registerBtn:UIButton = { () -> UIButton in
        let btn = UIButton()
        btn.setTitle("注册", for: UIControlState())
        btn.setTitleColor(UIColor.orange, for: UIControlState())
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), for: UIControlState())
        btn.addTarget(self, action: #selector(registerBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
}
