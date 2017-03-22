//
//  LoadingVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/21.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class LoadingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getInfo {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func getInfo(completed: @escaping ApiComplete) {
        let userDefault = UserDefaults.standard
        let id = userDefault.string(forKey: "id")!
        print(id)
        Alamofire.request("\(URL_SHOW_MEMBER)\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                // got an error in getting the data, need to handle it
                guard response.result.error == nil else {
                    print("error calling POST")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                print(json)
                
                // check data
                guard let phone = json["phone"] as? String else {
                    print("Could not get phone from JSON")
                    return
                }
                
                guard let coin = json["coin"] as? Int else {
                    print("Could not get coin from JSON")
                    return
                }
                
                guard let firstName = json["first_name"] as? String else {
                    print("Could not get firstName from JSON")
                    return
                }
                
                guard let lastName = json["last_name"] as? String else {
                    print("Could not get lastName from JSON")
                    return
                }
                
                
                // store member
                MEMBER = Member(firstName: firstName, lastName: lastName, phone: phone, coin: coin)
                
                completed()
        }
    }

}
