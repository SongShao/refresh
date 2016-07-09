//
//  RefreshItem.swift
//  下拉刷新动画
//
//  Created by lst on 16/5/23.
//  Copyright © 2016年 lst. All rights reserved.
//

import UIKit

class RefreshItem{
    //声明四个属性
    private var centerStart: CGPoint
    private var centerEnd: CGPoint
    unowned var view: UIView
    
//    初始化方法设置
    init(view: UIView,centerEnd: CGPoint, parallaxRatio: CGFloat, sceneHeight: CGFloat){
        //设置自身视图
        self.view = view
        //设置停止位置
        self.centerEnd = centerEnd
        //设置起始位置
        centerStart = CGPoint(x: centerEnd.x, y: centerEnd.y + (parallaxRatio * sceneHeight))
        //设置视图中心在起始位置
        self.view.center = centerStart
        
    }
    //声明方法  根据百分比更新视图中心位置
    func updataViewPositionForPercentage(percentage: CGFloat){
        view.center = CGPoint(
            x: centerStart.x + (centerEnd.x - centerStart.x) * percentage,
            y: centerStart.y + (centerEnd.y - centerStart.y) * percentage)
    }
}