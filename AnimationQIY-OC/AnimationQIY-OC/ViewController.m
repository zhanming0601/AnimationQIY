//
//  ViewController.m
//  AnimationQIY-OC
//
//  Created by zhanming on 16/5/27.
//  Copyright © 2016年 zhanming. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *backView=[UIView new];
    backView.backgroundColor=[UIColor blackColor];
    backView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2.5);
    [self.view addSubview:backView];
    UIImageView *backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loadinglogo"]];
    backImageView.frame=CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.width/3*0.7);
    backImageView.center=backView.center;
    
    [self.view addSubview:backImageView];
    
    AnimationView *animationView=[[AnimationView alloc]initWithFrame:CGRectMake(backImageView.frame.origin.x+60, CGRectGetMaxY(backImageView.frame), 18,18)];
    
    //animationView.backgroundColor=[UIColor redColor];
    [self.view addSubview:animationView];
}



@end
