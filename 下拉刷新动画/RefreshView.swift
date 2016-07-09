//
//  RefreshView.swift
//  下拉刷新动画
//
//  Created by lst on 16/5/23.
//  Copyright © 2016年 lst. All rights reserved.
//

import UIKit
//声明代理协议
protocol RefreshViewDelegat: class{
    func refreshViewDidRefresh(refreshView: RefreshView)
    
}
//加载动画范围
private let kSceneHeight: CGFloat = 120.0

class RefreshView: UIView,UIScrollViewDelegate {//遵循UIScrollViewDelegate
    //声明代理属性
    weak var refreshViewDelegate: RefreshViewDelegat?
    //声明一个bool值  来监听刷新  状态标示符
    var isrefreshing = false
    
    
    private var progress: CGFloat = 0.0
    private unowned var scrollview: UIScrollView
    
    //声明一个属性 数组
    var refreshItems = [RefreshItem]()
    
    init(frame: CGRect,scrollView: UIScrollView) {
        self.scrollview = scrollView
        super.init(frame: frame)
        //        backgroundColor = UIColor.greenColor()
        updateBackgroudColor()
        
        //调用setuorefreshitems
        setupRefreshItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  setupRefreshItems(){
        //加背景
        let groudImageview = UIImageView(image: UIImage(named: "ground"))
        //加建筑物
        let buildingsImageView = UIImageView(image: UIImage(named: "buildings"))
        //加太阳
        let sunImageView = UIImageView(image: UIImage(named: "sun"))
        //加猫
        let catImageView = UIImageView(image: UIImage(named: "cat"))
        //家斗篷
        let capeBackImageView = UIImageView(image: UIImage(named: "cape_back"))
        let capeFrontImageView = UIImageView(image: UIImage(named: "cape_front"))
        //添加云朵
        let cloudImageViewone = UIImageView(image: UIImage(named: "cloud_1"))
        
        let cloudImageViewtwo = UIImageView(image: UIImage(named: "cloud_1"))
        let cloudImageViewthree = UIImageView(image: UIImage(named: "cloud_1"))
         let cloudImageViewfour = UIImageView(image: UIImage(named: "cloud_1"))
         let cloudImageViewfive = UIImageView(image: UIImage(named: "cloud_1"))
        
        refreshItems = [
            
            
            //添加建筑物
            RefreshItem(view: buildingsImageView, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y:CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) / 2), parallaxRatio: 1.5, sceneHeight: kSceneHeight),
            
            //添加太阳
            RefreshItem(view: sunImageView, centerEnd:CGPoint(x:CGRectGetWidth(bounds) * 0.1 , y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(sunImageView.bounds)),parallaxRatio:  3.0, sceneHeight: kSceneHeight),
            //设置背景
            RefreshItem(view: groudImageview, centerEnd: CGPoint(x:CGRectGetMidX(bounds),y:CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) / 2), parallaxRatio: 0.5, sceneHeight: kSceneHeight),
            //添头蓬后部分
            RefreshItem(view: capeBackImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.5,y:CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 0.1), parallaxRatio: -1, sceneHeight: kSceneHeight),
            //添加猫
            RefreshItem(view: catImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.5,y:CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 0.1), parallaxRatio: 1, sceneHeight: kSceneHeight),
            //添加斗篷前部分
            RefreshItem(view: capeFrontImageView, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.5,y:CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 0.1), parallaxRatio: -1, sceneHeight: kSceneHeight),
            //加云朵
            RefreshItem(view: cloudImageViewone, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.25,y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds)  - CGRectGetHeight(cloudImageViewone.bounds) * 0.2 ), parallaxRatio: 0, sceneHeight: kSceneHeight),
            
             RefreshItem(view: cloudImageViewtwo, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.9,y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 5 - CGRectGetHeight(cloudImageViewone.bounds) * 0.2 ), parallaxRatio: 0, sceneHeight: kSceneHeight),
            
             RefreshItem(view: cloudImageViewthree, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.7,y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 4 - CGRectGetHeight(cloudImageViewone.bounds) * 0.2 ), parallaxRatio: 0, sceneHeight: kSceneHeight),
             RefreshItem(view: cloudImageViewfour, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.8,y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 3 - CGRectGetHeight(cloudImageViewone.bounds) * 0.2 ), parallaxRatio: 0, sceneHeight: kSceneHeight),
             RefreshItem(view: cloudImageViewfive, centerEnd: CGPoint(x:CGRectGetWidth(bounds) * 0.35,y: CGRectGetHeight(bounds) - CGRectGetHeight(groudImageview.bounds) - CGRectGetHeight(buildingsImageView.bounds) * 2 - CGRectGetHeight(cloudImageViewone.bounds) * 0.2 ), parallaxRatio: 0, sceneHeight: kSceneHeight)
            
        ]
        
        for refreshItem in refreshItems{
            addSubview(refreshItem.view)
        }
        
    }
    
    func updateBackgroudColor(){
        backgroundColor = UIColor(white: 0.7 * progress + 0.2, alpha: 1.0)
    }
    
    func updataRefreshItemPosition(){
        for refreshItem in refreshItems {
            refreshItem.updataViewPositionForPercentage(progress)
        }
    }
    
    //实行刷新方法
    func BeginRefreshing(){
        self.isrefreshing = true
        //调用动画方法
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseInOut, animations: {
            self.scrollview.contentInset.top += kSceneHeight
        }) { (_) in
            
        }
        let cape = refreshItems[3].view
        let cat = refreshItems[4].view
        cape.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI/32))
        cat.transform = CGAffineTransformMakeTranslation(1.0, 0)
        
        
        
        UIView.animateWithDuration(0.2, delay: 0, options: .Repeat, animations: {
            
            cape.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/32))
            cat.transform = CGAffineTransformMakeTranslation(-1.0, 0)
            
            }, completion: nil)
        
        
        let building = refreshItems[0].view
        let ground = refreshItems[2].view
        UIView.animateWithDuration(0.8, delay: 0 , options: .CurveEaseInOut, animations: {
            ground.center.y += kSceneHeight
            building.center.y += kSceneHeight
            }, completion: nil)
        let cloudone = refreshItems[6].view
        let cloudtwo = refreshItems[7].view
        let cloudthree = refreshItems[8].view
        let cloudfour = refreshItems[9].view
        let cloudfive = refreshItems[10].view
        
        UIView.animateWithDuration(5, delay: 0, options: .CurveEaseInOut, animations: {
            cloudone.center.y += 2 * kSceneHeight
            cloudtwo.center.y += 2 * kSceneHeight
            cloudthree.center.y += 2 * kSceneHeight
            cloudfour.center.y += 2 * kSceneHeight
            cloudfive.center.y += 2 * kSceneHeight
            }, completion: nil)

        
        
    }
    //结束刷新
    func EndRefresh(){
        //调用动画方法
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseInOut, animations: {
            self.scrollview.contentInset.top -= kSceneHeight
        }) { (_) in
            self.isrefreshing = false
        }
        let cape = refreshItems[3].view
        let cat = refreshItems[4].view
        cape.transform = CGAffineTransformIdentity
        cat.transform = CGAffineTransformIdentity
        cape.layer.removeAllAnimations()
        cat.layer.removeAllAnimations()
        
    }
    
    //在拖拽开始时执行刷新及发出通知
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if !isrefreshing && progress == 1{
            //1.执行开始刷新
            BeginRefreshing()
            
            //设置contenoffset.y的值
            targetContentOffset.memory.y = -scrollview.contentInset.top
            //发出通知
            refreshViewDelegate?.refreshViewDidRefresh(self)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //在刷新的时候不希望执行后续代码
        if isrefreshing{
            
            //在这里移除背景 添加云朵
            return
        }
        
        // 首先要拿到刷新可见区域的高度
        let refreshViewVisiableHeight = max(0,-scrollView.contentOffset.y - scrollView.contentInset.top)
        //  计算当前滚动的进度
        progress = min(1,refreshViewVisiableHeight / kSceneHeight)
        //根据进度来改变背景颜色
        updateBackgroudColor()
        //根据进度更新图片位置
        updataRefreshItemPosition()
    }
}
