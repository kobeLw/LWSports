//
//  NetManager.swift
//  LWSprots
//
//  Created by kobe on 2017/11/9.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit
import AFNetworking
//import SVProgressHUD

// 请求方法 GET / POST
enum HTTPMethod {
    case GET
    case POST
}

class NetManager: AFHTTPSessionManager {
    static let shared: NetManager = {
        // 实例化对象
        let instance = NetManager()
        
        // 设置响应反序列化支持的类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
    }()
    
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String:Any]?, completion:@escaping (_ response: Any?,_ isSuccess: Bool) -> Void) {
        
        // 成功回调
        let success = {(task: URLSessionTask, json: Any?) -> () in
            
            guard let result = (json as! [String:Any])["result"] as? [String:Any] else {
                return
            }
            
            // 错误码
            let statusCode = (result["status"] as! [String:Any])["code"] as! Int
            // 错误信息
            let msgStr = (result["status"] as! [String:Any])["msg"] as! String
            
            if statusCode == 0 {
                completion(json as Any?, true)
            } else {
//                SVProgressHUD.showError(withStatus: msgStr)
                print(msgStr)
                completion(json as Any?, false)
            }
        }
        
        //失败回调
        let failure = {(task: URLSessionDataTask?, error: Error) ->() in
            print("网络请求错误\(error)")
            completion(nil, false)
        }
        
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else{
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
        
    }
    
}


