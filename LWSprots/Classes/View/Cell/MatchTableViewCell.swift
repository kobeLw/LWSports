//
//  MatchTableViewCell.swift
//  LWSprots
//
//  Created by kobe on 2017/11/10.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit
import SDWebImage

class MatchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team1ImageV: UIImageView!
    
    @IBOutlet weak var team1Score: UILabel!
    
    @IBOutlet weak var team2Label: UILabel!
    
    @IBOutlet weak var team2ImageV: UIImageView!
    
    @IBOutlet weak var team2Score: UILabel!
    
    @IBOutlet weak var scroeLabel: UILabel!
    
    
    @IBOutlet weak var centerLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(matchDict: [String:Any]) {
        team1Label.text = matchDict["Team1"] as? String
        team2Label.text = matchDict["Team2"] as? String
        
        
        team1ImageV.sd_setImage(with: URL(string: (matchDict["Flag1_small"] as? String)!), completed: nil)
        team2ImageV.sd_setImage(with: URL(string: (matchDict["Flag2_small"] as? String)!), completed: nil)
        
        team1Score.text = matchDict["Score1"] as? String
        team2Score.text = matchDict["Score2"] as? String
        
        
        let matchStatus = matchDict["status"] as? String
        
        if matchStatus == "2"  {
            // 比赛结束
            self.statusLabel.text = matchDict["period_cn"] as? String
        } else {
            self.statusLabel.text = matchDict["status_cn"] as? String
        }
        
        if matchStatus == "1" {
            
            centerLabel.text = (matchDict["date"] as? String)! + "\n" + (matchDict["time"] as? String)!
            centerLabel.font = UIFont.systemFont(ofSize: 13)
            centerLabel.textColor = UIColor.red
            return
            
        } else {
            centerLabel.text = "-"
            centerLabel.font = UIFont.systemFont(ofSize: 18)
            centerLabel.textColor = UIColor.black
        }

        if (team1Score.text! as NSString).intValue > (team2Score.text! as NSString).intValue {
            team1Score.textColor = UIColor.red
        } else {
            team2Score.textColor = UIColor.red
        }

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
