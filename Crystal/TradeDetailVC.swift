//
//  TradeDetailVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/25.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit
import Alamofire

class TradeDetailVC: UIViewController {

    var date: String!
    var type: String!
    var details = [TradeDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.loadTradeDetail{
            for detail in self.details {
                //print(detail.product)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadTradeDetail(completed: @escaping ApiComplete) {
        let userDefault = UserDefaults.standard
        let id = userDefault.string(forKey: "id")!
        let params = ["date" : date!, "type" : type!]
        
        Alamofire.request("\(URL_TRADE_DETAIL)\(id)", parameters: params)
            .responseJSON { response in
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
                //print(json)
                
                guard let results = json["results"] as? [Dictionary<String,AnyObject>] else {
                    print("Could not get results from JSON")
                    return
                }
                
                //print("\(results.count)")
                
                // store trade details
                
                for detail in results {
                    self.details.append(TradeDetail(detailDict: detail))
                }
                
                completed()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
