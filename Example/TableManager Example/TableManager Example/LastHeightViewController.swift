//
//  LastHeightViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 03/01/17.
//  Copyright © 2017 Morbix. All rights reserved.
//

import Foundation
import TableManager

class LastHeightViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Fake.basicData().forEach { element in
            tableView.addRow().setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element + " (height: \(row.getHeight()))"
            }
        }
    }
}

extension LastHeightViewController: Screen {
    static func screenTitle() -> String {
        return "Last Height"
    }
}
