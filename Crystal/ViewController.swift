//
//  ViewController.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/10.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.viewDidAppear(animated)
        let userDefault = UserDefaults.standard
        let id = userDefault.string(forKey: "id")
        if id == nil || id! == "" {
            self.performSegue(withIdentifier: "loginView", sender: self)
        } else if MEMBER == nil{
            self.performSegue(withIdentifier: "loadingView", sender: self)
        }
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let userDefault = UserDefaults.standard
        userDefault.setValue("", forKey: "id")
        MEMBER = nil
        self.performSegue(withIdentifier: "loginView", sender: self)
    }

    
}

