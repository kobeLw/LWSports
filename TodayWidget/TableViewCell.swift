//
//  TableViewCell.swift
//  TodayWidget
//
//  Created by kobe on 2017/12/12.
//  Copyright © 2017年 kobe. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var team1ImageV: UIImageView!
    
    @IBOutlet weak var team1Label: UILabel!
    
    @IBOutlet weak var team2Label: UILabel!
    
    
    @IBOutlet weak var team2ImageV: UIImageView!
    
    @IBOutlet weak var scroeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
