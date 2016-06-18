//
//  DragAndDropViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 18/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class DragAndDropViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(barButtonTouched))
        
        tableView.tableManagerDelegate = self // The delegate is optional. Set just if you want be notified what the row was moved
        
        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.setCanMove(true)
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }

    // MARk: Actions
    
    final func barButtonTouched() {
        tableView.editing = !tableView.editing
    }
    
}

extension DragAndDropViewController: TableManagerDelegate {
    
    func tableManagerDidMove(fromRow: Row, fromIndexPath: NSIndexPath, toRow: Row, toIndexPath: NSIndexPath) {
        print("move action: " + fromIndexPath.debugDescription + " to " + fromIndexPath.debugDescription)
    }
    
}
