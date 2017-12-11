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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(matchDict: [String:Any]) {
        team1Label.text = matchDict["Team1"] as? String
        team2Label.text = matchDict["Team2"] as? String
        
        
        team1ImageV.sd_setImage(with: URL(string: (matchDict["Flag1"] as? String)!), completed: nil)
        team2ImageV.sd_setImage(with: URL(string: (matchDict["Flag2"] as? String)!), completed: nil)
        
        team1Score.text = matchDict["Score1"] as? String
        team2Score.text = matchDict["Score2"] as? String

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
