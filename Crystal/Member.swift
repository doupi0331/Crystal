//
//  Member.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/13.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class Member {
    private var _id: String!
    private var _firstName: String!
    private var _lastName: String!
    private var _phone: String!
    private var _birthDate: String!
    private var _coin: Int!
    
    var firstName: String {
        if _firstName == nil {
            return ""
        }
        return _firstName
    }
    
    var lastName: String {
        if _lastName == nil {
            return ""
        }
        return _lastName
    }
    
    var phone: String {
        if _phone == nil {
            return ""
        }
        return _phone
    }
    
    var birthDate: String {
        if _birthDate == nil {
            return ""
        }
        return _birthDate
    }
    
    var coin: Int {
        if _coin == nil {
            return 0
        }
        return _coin
    }
    
    var fullName: String {
        return "\(lastName)\(firstName)"
    }
    
    init(firstName: String, lastName: String, phone: String, coin: Int) {
        self._firstName = firstName
        self._lastName = lastName
        self._phone = phone
        self._coin = coin
    }
    
}
