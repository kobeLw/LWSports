//
//  ViewController.swift
//  LWSprots
//
//  Created by kobe on 2017/11/6.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var selectButton: UIButton!
    
    var lineView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "LWSports"
        
        
        setUI()
    }
    
    func setUI() {
        let buttonTittle = ["NBA","欧冠","西甲","英超"]
        
        for i in 0..<4 {
            let button = UIButton(type: .custom)
            let buttonWidth = kScreenWidth / 4
            button.frame = CGRect(x: buttonWidth * CGFloat(i), y: 64, width: buttonWidth, height: 30)
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
    }
    
    @objc func chooseMatchType(button: UIButton) {
        
        if selectButton != button {
            
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

