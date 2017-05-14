//
//  Trade.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/24.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

class Trade {
    private var _date: String!
    private var _type: String!
    private var _total: Int!
    
    var date: String {
        if _date == nil {
            return ""
        }
        return _date
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var description: String {
        if type == "O" {
            return "消費"
        } else if type == "I" {
            return "儲值"
        }
        return ""
    }
    
    var total: Int {
        if _total == nil {
            return 0
        }
        return _total
    }
    
    var totalDisplay: String {
        if type == "I" {
            return "+\(total.stringFormattedWithSeparator)"
        } else if type == "O" {
            return "-\(total.stringFormattedWithSeparator)"
        }
        return ""
    }
    
    init(tradeDict: Dictionary<String, AnyObject>) {
        if let total = tradeDict["total"] as? Int {
            self._total = total
        }
        if let date = tradeDict["trade_date"] as? String {
            self._date = date
        }
        if let type = tradeDict["trade_type"] as? String {
            self._type = type
        }
    }
}
