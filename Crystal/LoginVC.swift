//
//  LoginVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/12.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {

    
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    var data = [String : Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func loginPressed(_ sender: Any) {
        
        let phone = phoneTxt.text!
        let password = passwordTxt.text!
        
        if phone.isEmpty || password.isEmpty {
            let alert = MESSAGE(title: "", message: "請填妥所有欄位")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        data = ["phone" : phone,
                "password" : password]
        
        self.login {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // api
    func login(completed: @escaping ApiComplete) {
        Alamofire.request(URL_LOGIN, method: .post, parameters: data, encoding: JSONEncoding.default)
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
                
                // get data error message
                if let message = json["message"] as? String {
                    if message == "failed" {
                        if let error = json["error"] as? String {
                            let alert = MESSAGE(title: "", message: error)
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                }
                if let status = json["status"] as? Int {
                    if status == 404 {
                        if let error = json["error"] as? String {
                            if error == "Not Found" {
                                let alert = MESSAGE(title: "", message: "此行動電話尚未註冊")
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                        return
                    }
                }
                
                // get the id
                guard let id = json["id"] as? String else {
                    print("Could not get id from JSON")
                    return
                }
                
                //print("The id is: " + id)
                
                // store member id
                let userDefault = UserDefaults.standard
                userDefault.setValue(id, forKey: "id")
                
                completed()
        }
        
    }
}
