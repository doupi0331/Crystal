//
//  TradeCell.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/24.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

class TradeCell: UITableViewCell {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tradeNameLabel: UILabel!
    @IBOutlet weak var tradeDateLabel: UILabel!
    @IBOutlet weak var cell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(trade: Trade) {
        if trade.type == "I" {
            cell.backgroundColor = UIColor(red: 102.0/255.0, green: 192.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor(red: 255.0/255.0, green: 88.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        }
        totalLabel.text = trade.totalDisplay
        tradeNameLabel.text = trade.description
        tradeDateLabel.text = trade.date
    }

}
