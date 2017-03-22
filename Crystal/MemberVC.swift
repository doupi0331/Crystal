//
//  MemberVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/20.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

class MemberVC: UIViewController {

    @IBOutlet weak var coinView: UIView!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinView.layer.cornerRadius = 10.0

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if MEMBER != nil {
            self.nameLabel.text = MEMBER.fullName
            self.phoneLabel.text = MEMBER.phone
            self.coinLabel.text = MEMBER.coin.stringFormattedWithSeparator
            self.nameLabel.isHidden = false
            self.phoneLabel.isHidden = false
            self.coinLabel.isHidden = false
        }
    }
    
    

}
