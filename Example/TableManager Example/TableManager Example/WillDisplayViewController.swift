//
//  WillDisplayViewController.swift
//  TableManager Example
//
//  Created by Juliano Rotta on 21/08/17.
//  Copyright © 2017 Morbix. All rights reserved.
//

import UIKit
import TableManager

class WillDisplayViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Fake.basicData().forEach { element in
            tableView.addRow().setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
                }.setWillDisplay { (row, tableView, cell, indexPath) in
                    print("Will display row \(indexPath.row)")
            }
        }
        
        tableView.reloadData()
    }
    
}

extension WillDisplayViewController: Screen {
    static func screenTitle() -> String {
        return "Will Display Cell"
    }
}
