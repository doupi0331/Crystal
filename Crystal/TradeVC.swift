//
//  TradeVC.swift
//  Crystal
//
//  Created by Yi-Yun Chen on 2017/3/24.
//  Copyright © 2017年 Yi-Yun Chen. All rights reserved.
//

import UIKit

class TradeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTradeDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! TradeDetailVC
                destination.date = TRADES[indexPath.row].date
                destination.type = TRADES[indexPath.row].type
            }
        }
    }
    
    
    // table
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TRADES.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TradeCell", for: indexPath) as? TradeCell {
            let trade = TRADES[indexPath.row]
            cell.configureCell(trade: trade)
            return cell
        } else {
            return TradeCell()
        }
    }


}
