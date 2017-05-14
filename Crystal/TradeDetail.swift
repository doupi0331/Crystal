//
//  TradeDetail.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/25.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

class TradeDetail {
    private var _product: String!
    private var _currentPrice: Int!
    private var _amount: Int!
    private var _total: Int!
    
    var product: String {
        if _product == nil {
            return ""
        }
        return _product
    }
    
    var currentPrice: Int {
        if _currentPrice == nil {
            return 0
        }
        return _currentPrice
    }
    
    var amount: Int {
        if _amount == nil {
            return 0
        }
        return _amount
    }
    
    var total: Int {
        if _total == nil {
            return 0
        }
        return _total
    }
    
    init(detailDict: Dictionary<String, AnyObject>) {
        if let total = detailDict["total"] as? Int {
            self._total = total
        }
        if let product = detailDict["product"] as? String {
            self._product = product
        }
        if let currentPrice = detailDict["current_price"] as? Int {
            self._currentPrice = currentPrice
        }
        if let amount = detailDict["amount"] as? Int {
            self._amount = amount
        }

    }
}
