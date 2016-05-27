//
//  ViewController.swift
//  AnimationQIY-swift
//
//  Created by zhanming on 16/5/27.
//  Copyright © 2016年 zhanming. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
//        UIView *backView=[UIView new];
//        backView.backgroundColor=[UIColor blackColor];
//        backView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2.5);
//        [self.view addSubview:backView];
//        UIImageView *backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loadinglogo"]];
//        backImageView.frame=CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.width/3*0.7);
//        backImageView.center=backView.center;
//        
//        [self.view addSubview:backImageView];
//        
//        AnimationView *animationView=[[AnimationView alloc]initWithFrame:CGRectMake(backImageView.frame.origin.x+60, CGRectGetMaxY(backImageView.frame), 18,18)];
//        
//        //animationView.backgroundColor=[UIColor redColor];
//        [self.view addSubview:animationView];
        
        let backView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/2.5))
        backView.backgroundColor=UIColor.blackColor()
        view.addSubview(backView)
        
        let backImageView = UIImageView(image: UIImage(named: "loadinglogo"))
        backImageView.frame=CGRectMake(0, 0, self.view.frame.size.width*0.7, self.view.frame.size.width/3*0.7)
        backImageView.center=backView.center
        view.addSubview(backImageView)
        let animationView = AnimationView(frame: CGRectMake(backImageView.frame.origin.x+60, CGRectGetMaxY(backImageView.frame), 18,18))
        view.addSubview(animationView)
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

