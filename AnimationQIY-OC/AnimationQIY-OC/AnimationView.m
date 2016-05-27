//
//  AnimationView.m
//  storyboard
//
//  Created by zhanming on 16/5/27.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "AnimationView.h"
#import "triangleView.h"
#define  NSTimeInterval 0.7;

@interface AnimationView ()
@property(nonatomic,strong)CAShapeLayer * maskLayer;
@property(nonatomic,strong)triangleView * centerImage;
@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    

    //因为没有找到合适的图，我自己画了一个等边三角形，其实这个可以让美工做一个图，你把imageView放到中间即可

    triangleView *centerImage=[triangleView new];
    self.centerImage=centerImage;
    centerImage.frame=CGRectMake(0,0, self.bounds.size.width*0.5, self.bounds.size.width*0.5);
    centerImage.center=CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2);
    
    [self addSubview:centerImage];
    
    //画一个圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor=[UIColor clearColor].CGColor;
    //将路径赋值给CAShapeLayer
    maskLayer.path = path.CGPath;
    
    //设置路径的颜色
    maskLayer.strokeColor=[UIColor colorWithRed:0.52f green:0.76f blue:0.07f alpha:1.00f].CGColor;
    //设置路径的宽度
    maskLayer.lineWidth=1;
    maskLayer.lineCap=kCALineCapRound;
    
    [self.layer addSublayer:maskLayer];
    self.maskLayer=maskLayer;
    
    
    self.maskLayer.transform=CATransform3DRotate(self.maskLayer.transform, -M_PI_2, 0, 0, 1);
    self.maskLayer.transform=CATransform3DTranslate(self.maskLayer.transform, -self.bounds.size.width,0,0);
    [self animationOne];

}

-(void)animationOne
{
    
    /*注意
    我们知道，使用 CAAnimation 如果不做额外的操作，动画会在结束之后返回到初始状态。或许你会这么设置：
    
    radiusAnimation.fillMode = kCAFillModeForwards;
    radiusAnimation.removedOnCompletion = NO;
    
    但这不是正确的方式。正确的做法可以参考 WWDC 2011 中的 session 421 - Core Animation Essentials。
    Session 中推荐的做法是先显式地改变 Model Layer 的对应属性，再应用动画。这样一来，我们甚至省去了 toValue。
    首先显式地设定属性的终止状态，strokeEnd的值为:self.maskLayer.strokeEnd=0.98;
     */
    
    self.maskLayer.strokeStart=0;
    //设置strokeEnd的最终值，动画的fromValue为0，strokeEnd的最终值为0.98
    self.maskLayer.strokeEnd=0.98;
    CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    BasicAnimation.fromValue=@(0);
    
    BasicAnimation.duration=NSTimeInterval;
 
    BasicAnimation.delegate=self;
    [BasicAnimation setValue:@"BasicAnimationEnd" forKey:@"animationName"];
    
    
    
    [self.maskLayer addAnimation:BasicAnimation forKey:@"BasicAnimationEnd"];
}
-(void)animationTwo
{
    self.maskLayer.strokeStart=0.98;
    CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"strokeStart"];
    BasicAnimation.fromValue=@(0);
    //BasicAnimation.toValue=@(1);
    BasicAnimation.duration=NSTimeInterval;
    //BasicAnimation.repeatCount=MAXFLOAT;
    
    BasicAnimation.delegate=self;
    [BasicAnimation setValue:@"BasicAnimationStart" forKey:@"animationName"];
    [self.maskLayer addAnimation:BasicAnimation forKey:@"BasicAnimationStart"];
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    
    if([[anim valueForKey:@"animationName"] isEqualToString:@"BasicAnimationEnd"])
    {
        
        //当画圆的动画完成后同时开始三角形旋转和开始圆消失的动画
        
        //开始三角形旋转
        CABasicAnimation *BasicAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
        BasicAnimation.toValue=@(M_PI*2);
        BasicAnimation.duration=NSTimeInterval;
   
        BasicAnimation.delegate=self;
        [BasicAnimation setValue:@"BasicAnimationRotation" forKey:@"animationName"];
        [self.centerImage.layer addAnimation:BasicAnimation forKey:@"BasicAnimationRotation"];
        
        //开始圆消失的动画
        [self animationTwo];
    }
    else if([[anim valueForKey:@"animationName"] isEqualToString:@"BasicAnimationStart"])
    {
        
        //当圆消失动画完成后，清除所有动画从新开始画圆动画
        [self.maskLayer removeAllAnimations];
        [self.centerImage.layer removeAllAnimations];
        [self animationOne];
    }
    

}


@end
