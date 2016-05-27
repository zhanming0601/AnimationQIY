//
//  triangleView.swift
//  AnimationQIY-swift
//
//  Created by zhanming on 16/5/27.
//  Copyright © 2016年 zhanming. All rights reserved.
//

import UIKit

class triangleView: UIView {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        
        
        let width = self.frame.size.width*0.65;
        let width2 = width/(sqrt(3));
        
        let centerX = self.frame.size.width/2;
        let centerY = self.frame.size.width/2;
        
        let PointA=CGPointMake(centerX+(width*(2/3.0)), centerY);
        let PointB=CGPointMake(PointA.x-width, PointA.y-width2);
        let PointC=CGPointMake(PointB.x, PointB.y+2*width2);
        let path = UIBezierPath()
        path.moveToPoint(PointA)
        path.addLineToPoint(PointB)
        path.addLineToPoint(PointC)
        
        path.closePath()
        
        // 设置填充颜色
        let fillColor = UIColor(red: 0.52, green: 0.67, blue: 0.07, alpha: 1.00)
        
   
        fillColor.set()
        path.fill()
        
        
        // 根据我们设置的各个点连线
        path.stroke()

        
    }
   

}
