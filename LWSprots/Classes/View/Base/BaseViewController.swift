//
//  BaseViewController.swift
//  LWSprots
//
//  Created by kobe on 2017/11/9.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableV: UITableView!
    
    // 接口地址
    var urlStr: String?
    
    // 数据源
    var dataArr: [Any]?
    
    var noMatchLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.white
        
        dataArr = [Any]()
        urlStr = ""//NBAURLString
        
        
        setUI()
        getData()
        
    }
    
    func setUI() {
        
        self.tableV = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 94), style: .plain)
        self.tableV.delegate = self
        self.tableV.dataSource = self
        self.tableV.showsVerticalScrollIndicator = false
        self.tableV.showsHorizontalScrollIndicator = false
        self.tableV.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: "cellid")
        self.tableV.tableFooterView = UIView()
        view.addSubview(self.tableV)
        
        noMatchLabel = UILabel(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 40))
        noMatchLabel.center = view.center
        noMatchLabel.text = "今日没有比赛"
        noMatchLabel.textAlignment = .center
        noMatchLabel.isHidden = true
        view.addSubview(noMatchLabel)
        
        
    }
    
    
    
    func getData() {
        if urlStr == "" {
            return
        }
        NetManager.shared.request(URLString: urlStr!, parameters: nil) { (response, isSuccess) in
            
            if isSuccess
            {
                let dataDic = ((response as! [String:Any])["result"] as! [String:Any])["data"]
                let dict = (dataDic as! [String:Any])["full"] as! [[String:Any]]
                let curDict = (dataDic as! [String:Any])["cur"] as! [[String:Any]]
                
                if curDict.count == 0
                {
                    for matchDict in dict
                    {
                        if (matchDict["date"] as! String) == Tools().currentDate()
                        {
                            self.dataArr?.append(matchDict)
                        }
                    }
                } else {
                    for matchDict in curDict
                    {
                        if (matchDict["date"] as! String) == Tools().currentDate()
                        {
                            self.dataArr?.append(matchDict)
                        }
                    }
                }
                
                
//                print(self.dataArr ?? "")
                if self.dataArr?.count == 0
                {
                    self.noMatchLabel.isHidden = false
                    self.tableV.isHidden = true
                    return
                }
                self.tableV.reloadData()
                if self.urlStr == NBAURLString
                {
                    let dataShare = UserDefaults(suiteName: "group.com.LWSports")
                    dataShare?.set(self.dataArr, forKey: "NBA_Data")
                }
            }
        }
    }
    
    // MARK: ------ tableview delegate/datasource ------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! MatchTableViewCell

        guard let matchDic = (self.dataArr![indexPath.row] as? [String:Any]) else {
            print("有错误")
            return cell
        }
        cell.config(matchDict: matchDic)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
