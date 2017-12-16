//
//  TodayViewController.swift
//  TodayWidget
//
//  Created by kobe on 2017/12/12.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding,UITableViewDelegate,UITableViewDataSource {
    
    // 数据源
    var dataArr: [Any]?
    
    var tableV: UITableView!
    
    var selectButton: UIButton!
    
    
    var label: UILabel = {
        let v = UILabel()
        v.text = "未点击"
        v.backgroundColor = UIColor.red
        return v
    }()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        dataArr = [Any]()
        
        createUI()
        
        getData(urlStr: NBAURLString)
//        label.frame = CGRect(x: 20, y: 50, width: 100, height: 40)
//        view.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            self.preferredContentSize = maxSize
        } else if activeDisplayMode == .expanded {
            self.preferredContentSize = CGSize(width: 0, height: 430)
        }
    }
    
    func createUI() {
        let titleArr = ["NBA","欧冠","西甲","英超"]
        
        for i in 0..<4 {
            let button = UIButton(frame: CGRect(x: self.view.frame.width / 4 * CGFloat(i), y: 0, width: self.view.frame.width / 4, height: 40))
            button.setTitle(titleArr[i], for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.addTarget(self, action: #selector(click), for: .touchUpInside)
            button.tag = 100 + i
            view.addSubview(button)
            
            if i == 0
            {
                button.setTitleColor(UIColor.red, for: .normal)
                selectButton = button
            }
            
        }
        
        
        tableV = UITableView(frame: CGRect(x: 0, y: 40, width: self.view.frame.size.width, height: 390), style: .plain)
//        tableV.backgroundColor = UIColor.red
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.showsHorizontalScrollIndicator = false
        tableV.tableFooterView = tableviewFootView()
        self.tableV.register(UINib(nibName: "MatchTableViewCell", bundle: nil), forCellReuseIdentifier: "today")
        self.tableV.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "noMatch")
        view.addSubview(tableV)
    }
    
    func tableviewFootView() -> UIView {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: tableV.frame.width, height: 30)
        button.setTitle("全部比赛>>", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button .addTarget(self, action: #selector(allMatch), for: .touchUpInside)
        return button
    }
    
    // MARK: ------ 点击查看全部比赛 ------
    @objc func allMatch() {
        self.extensionContext?.open(URL(string: "LaLigaViewController://")!, completionHandler: { (isSuccess) in
            
        })
    }
    
    // MARK: ------ tableview delegate / datasource ------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataArr?.count == 0 {
            return 1
        } else if (self.dataArr?.count)! > 6 {
            return 6
        }
        return (self.dataArr?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 没有比赛
        if self.dataArr?.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "noMatch") as! TableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "today") as! MatchTableViewCell

        guard let matchDic = (self.dataArr![indexPath.row] as? [String:Any]) else {
            print("有错误")
            return cell
        }
        cell.config(matchDict: matchDic)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataArr?.count == 0 {
            return 360
        }
        return 60
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.extensionContext?.open(URL(string: "LaLigaViewController://")!, completionHandler: { (isSuccess) in
            
        })
    }
    
    
    
    
    
    @objc func click(button: UIButton) {
        
        if selectButton == button {
            return
        }
        
        selectButton.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        selectButton = button
        
        self.dataArr?.removeAll()
        switch button.tag {
        case 100:
            getData(urlStr: NBAURLString)
            break
        case 101:
            getData(urlStr: UEFAURLString)
            break
        case 102:
            getData(urlStr: LaLigaURLString)
            break
        case 103:
            getData(urlStr: PremierLeagueURLString)
        default:
            break
        }
    }
    
    // MARK: ------ 请求数据 ------
    func getData(urlStr: String) {
        
        
        NetManager.shared.request(URLString: urlStr, parameters: nil) { (response, isSuccess) in
            
            if isSuccess
            {
                let currentDate = ((response as! [String:Any])["result"] as! [String:Any])["begin"] as! String
                let dataDic = ((response as! [String:Any])["result"] as! [String:Any])["data"]
                let fullDict = (dataDic as! [String:Any])["full"] as! [[String:Any]]
                let curDict = (dataDic as! [String:Any])["cur"] as! [[String:Any]]
                let preDict = (dataDic as! [String:Any])["pre"] as! [[String:Any]]
                
                // 没有正在打的比赛
                if curDict.count == 0
                {
                    for matchDict in fullDict
                    {
                        if (matchDict["date"] as! String) == currentDate
                        {
                            self.dataArr?.append(matchDict)
                        }
                    }
                } else {
                    for matchDict in curDict
                    {
                        if (matchDict["date"] as! String) == currentDate
                        {
                            self.dataArr?.append(matchDict)
                        }
                    }
                    for matchDict in fullDict
                    {
                        if (matchDict["date"] as! String) == currentDate
                        {
                            self.dataArr?.append(matchDict)
                        }
                    }
                }
                
                // 今天没有比赛
                if self.dataArr?.count == 0
                {
                    self.dataArr = preDict
                }
                
                self.tableV.reloadData()
                
                //                print(self.dataArr ?? "")
                
//                self.tableV.reloadData()
//                if self.urlStr == NBAURLString
//                {
//                    let dataShare = UserDefaults(suiteName: "group.com.LWSports")
//                    dataShare?.set(self.dataArr, forKey: "NBA_Data")
//                }
            }
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
