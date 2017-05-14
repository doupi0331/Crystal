//
//  Constants.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/13.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

typealias ApiComplete = () -> ()

var MEMBER: Member!
var TRADES = [Trade]()

let URL_BASE = "https://crystal-app.herokuapp.com/api/v1/"

// models
let URL_MEMBER = "members/"
let URL_TRADE = "trades/"

// Resful URL
let URL_SINGUP = "\(URL_BASE)\(URL_MEMBER)"
let URL_LOGIN = "\(URL_BASE)login/"
let URL_SHOW_MEMBER = "\(URL_BASE)\(URL_MEMBER)"
let URL_SHOW_TRADES = "\(URL_BASE)\(URL_MEMBER)\(URL_TRADE)"
let URL_TRADE_DETAIL = "\(URL_BASE)\(URL_TRADE)"


// function
func MESSAGE(title: String, message: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "確認", style: .default, handler: nil)
    alert.addAction(okAction)
    return alert
}

// Number format
struct Number {
    static let formatterWithSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var stringFormattedWithSeparator: String {
        return Number.formatterWithSeparator.string(from: self as! NSNumber) ?? ""
    }
}
