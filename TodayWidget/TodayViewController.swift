//
//  TodayViewController.swift
//  TodayWidget
//
//  Created by kobe on 2017/11/10.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit
import NotificationCenter


class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        let dataShare = UserDefaults(suiteName: "group.com.LWSports")
        let str = dataShare?.object(forKey: "lakers") as? String
        print(str ?? "")
        label.text = str

        
        
        self.label.isUserInteractionEnabled = true
        self.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(click)))
        
        
    }
    
    @objc func click() {
        
        let url = URL(fileURLWithPath: "NBAViewController://")
        self.extensionContext?.open(url, completionHandler: { (isSuccess) in
            print(isSuccess)
        })
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else {
            self.preferredContentSize = CGSize(width: 0, height: 400)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
