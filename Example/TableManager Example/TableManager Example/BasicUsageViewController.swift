//
//  BasicUsageViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 14/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class BasicUsageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = (1...100).map { "Row \($0)" }
        
        data.forEach { element in
            tableView.addRow().setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }

}
