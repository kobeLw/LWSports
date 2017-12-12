//
//  ViewController.swift
//  LWSprots
//
//  Created by kobe on 2017/11/6.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIScrollViewDelegate {
    
    // 当前选中按钮
    var selectButton: UIButton!
    
    var lineView: UIView!
    
    var scrollV: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "LWSports"
        
        
        let dataShare = UserDefaults(suiteName: "group.LWSprots")
        dataShare?.set("kobe bryant", forKey: "name1")
        
        
        
        
        
        setUI()
    }
    
    func setUI() {
        let buttonTittle = ["NBA","欧冠","西甲","英超"]
        
        // 顶部四个按钮
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            let buttonWidth = kScreenWidth / 4
            button.frame = CGRect(x: buttonWidth * CGFloat(i), y: 64, width: buttonWidth, height: 30)
            if isIPhoneX
            {
                button.frame = CGRect(x: buttonWidth * CGFloat(i), y: 88, width: buttonWidth, height: 30)
            }
            button.setTitle(buttonTittle[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.tag = 100 + i
            button.addTarget(self, action: #selector(chooseMatchType), for: .touchUpInside)
            view.addSubview(button)
            
            view.isUserInteractionEnabled = true
            
            
            if i == 0
            {
                
                
                lineView = UIView(frame: CGRect(x: button.frame.minX, y: button.frame.maxY - 1, width: buttonWidth, height: 1))
                lineView.backgroundColor = UIColor.red
                view.addSubview(lineView)
                
                button.setTitleColor(UIColor.red, for: .normal)
                selectButton = button
            }
        }
        
        // 下面scrollview
        scrollV = UIScrollView(frame: CGRect(x: 0, y: lineView.frame.maxY, width: kScreenWidth, height: kScreenHeight - lineView.frame.maxY))
        scrollV.delegate = self
        scrollV.isPagingEnabled = true
        scrollV.contentSize = CGSize(width: kScreenWidth * 4, height: 0)
        scrollV.showsVerticalScrollIndicator = false
        scrollV.showsHorizontalScrollIndicator = false
        view.addSubview(scrollV)
        
        
        let nbaVC = NBAViewController()
        let nbaView = nbaVC.view
        nbaView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: scrollV.frame.height)
        scrollV.addSubview(nbaView!);
        self.addChildViewController(nbaVC)
        
        let uefaVC = UEFAViewController()
        let uefaView = uefaVC.view
        uefaView?.frame = CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: scrollV.frame.height)
        scrollV.addSubview(uefaView!)
        self.addChildViewController(uefaVC)
        
        
        let laLigaVC = LaLigaViewController()
        let laLigaView = laLigaVC.view
        laLigaView?.frame = CGRect(x: kScreenWidth * 2, y: 0, width: kScreenWidth, height: scrollV.frame.height)
        scrollV .addSubview(laLigaView!)
        self.addChildViewController(laLigaVC)

        let preVC = PremierLeagueViewController()
        let preView = preVC.view
        preView?.frame = CGRect(x: kScreenWidth * 3, y: 0, width: kScreenWidth, height: scrollV.frame.height)
        scrollV .addSubview(preView!)
        self.addChildViewController(preVC)
        
    }
    
    @objc func chooseMatchType(button: UIButton) {
        
        if selectButton != button {
            
            scrollV.setContentOffset(CGPoint(x: CGFloat(button.tag - 100) * kScreenWidth, y: 0), animated: true)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.lineView.frame = CGRect(x: button.frame.minX, y: button.frame.maxY - 1, width: button.frame.width, height: 1)
            })
            button.setTitleColor(UIColor.red, for: .normal)
            selectButton.setTitleColor(UIColor.black, for: .normal)
            
            selectButton = button
        } else {
            return;
        }
        
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / kScreenWidth
        
        if currentPage == CGFloat(selectButton.tag - 100) {
            return
        }
        
        let button = view.viewWithTag(Int(100 + currentPage)) as! UIButton
        button.setTitleColor(UIColor.red, for: .normal)
        selectButton.setTitleColor(UIColor.black, for: .normal)
        selectButton = button
        
        
        
        
        UIView.animate(withDuration: 0.3, animations: {
            self.lineView.frame = CGRect(x: button.frame.minX, y: button.frame.maxY - 1, width: button.frame.width, height: 1)
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

