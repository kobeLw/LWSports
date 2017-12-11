//
//  Tools.swift
//  LWSprots
//
//  Created by kobe on 2017/11/10.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit

class Tools: NSObject {
    
    public func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateTime = formatter.string(from:Date())
        return dateTime
    }

    
    
    
}
