//
//  refreshViewController.swift
//  下拉刷新动画
//
//  Created by lst on 16/5/23.
//  Copyright © 2016年 lst. All rights reserved.
//

import UIKit
private let kRefreshViewHeight:CGFloat = 300.0
class refreshViewController: UITableViewController , RefreshViewDelegat{
    private var refreshView: RefreshView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView = RefreshView(frame: CGRect(x: 0 ,y: -kRefreshViewHeight, width:CGRectGetWidth(view.bounds) ,height: kRefreshViewHeight), scrollView: tableView)
        
        view.insertSubview(refreshView, atIndex: 0)
        
        refreshView.refreshViewDelegate = self
        
        }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
         //在这里我们要把通知发送给refreshview中
        refreshView.scrollViewDidScroll(scrollView)
    }
    //接收通知执行代理
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //执行刷新
        refreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    // MARK: - 执行代理方法 (刷新数据)(延迟执行结束刷新)
    func refreshViewDidRefresh(refreshView: RefreshView) {
        //这里执行数据请求 (延迟执行)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 4))
       
        dispatch_after(time, dispatch_get_main_queue()) {
            
            refreshView.EndRefresh()
        }
      
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)

        cell.textLabel?.text = "这是第\(indexPath.row)"
        return cell
    }
   
}
