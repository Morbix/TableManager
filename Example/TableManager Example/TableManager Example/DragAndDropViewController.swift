//
//  DragAndDropViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 18/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit

class DragAndDropViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.setCanMove(true)
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
        
        tableView.editing = true
    }

}
