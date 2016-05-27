//
//  AnimationView.swift
//  AnimationQIY-swift
//
//  Created by zhanming on 16/5/27.
//  Copyright © 2016年 zhanming. All rights reserved.
//

import UIKit

class AnimationView: UIView {

    var NSTimeInterval:Double = 0.65
    
    
    
    lazy var centerImage:triangleView={
       
        var centerImage=triangleView(frame: CGRectMake(0,0, self.bounds.size.width*0.5, self.bounds.size.width*0.5))
        centerImage.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2)
        
        return centerImage;
    }()
    
    var myMaskLayer:CAShapeLayer?
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUp()
    {
        //因为没有找到合适的图，我自己画了一个等边三角形，其实这个可以让美工做一个图，你把imageView放到中间即可
        
 
        self.addSubview(centerImage);
        

        //画一个圆
        let path = UIBezierPath(ovalInRect: self.bounds)
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor=UIColor.clearColor().CGColor
        //将路径赋值给CAShapeLayer
        maskLayer.path=path.CGPath;
        //设置路径的颜色
        maskLayer.strokeColor=UIColor(red: 0.52, green: 0.76, blue: 0.07, alpha: 1.00).CGColor
        //设置路径的宽度
        maskLayer.lineWidth=1;
        maskLayer.lineCap=kCALineCapRound
        
        self.layer.addSublayer(maskLayer)
        maskLayer.transform=CATransform3DRotate(maskLayer.transform, CGFloat(-M_PI_2), 0, 0, 1)
  
        maskLayer.transform=CATransform3DTranslate(maskLayer.transform, -self.bounds.size.width, 0,0)
        
        
        myMaskLayer=maskLayer
        animationOne()
        
    }
    
    
    func animationOne() {
        myMaskLayer?.strokeStart=0;
        myMaskLayer?.strokeEnd=0.98
        
        let BasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        BasicAnimation.fromValue=0
        BasicAnimation.duration=NSTimeInterval
        BasicAnimation.delegate=self
        
        BasicAnimation.setValue("BasicAnimationEnd", forKey: "animationName")
        myMaskLayer?.addAnimation(BasicAnimation, forKey:"BasicAnimationEnd")
        
    
    }
    func animationTwo() {
        
        
        myMaskLayer?.strokeStart=0.98
        let BasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        BasicAnimation.fromValue=0
        BasicAnimation.duration=NSTimeInterval
        BasicAnimation.delegate=self
        
        BasicAnimation.setValue("BasicAnimationStart", forKey: "animationName")
        myMaskLayer?.addAnimation(BasicAnimation, forKey:"BasicAnimationStart")
        
        
    }

    


    
}

extension AnimationView
{
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        
        if(anim.valueForKey("animationName") as! String == "BasicAnimationEnd")
        {
            //当画圆的动画完成后同时开始三角形旋转和开始圆消失的动画
            //
            //开始三角形旋转
            let BasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            BasicAnimation.toValue=CGFloat(2*M_PI)
            BasicAnimation.duration=NSTimeInterval
            BasicAnimation.delegate=self
            
            BasicAnimation.setValue("BasicAnimationRotation", forKey: "animationName")
            centerImage.layer.addAnimation(BasicAnimation, forKey:"BasicAnimationRotation")
            //开始圆消失的动画
            animationTwo()
        }
        else if(anim.valueForKey("animationName") as! String == "BasicAnimationStart")
        {
            //当圆消失动画完成后，清除所有动画从新开始画圆动画
            myMaskLayer?.removeAllAnimations()
            centerImage.layer.removeAllAnimations()
            animationOne()
        }
        

    }
}


