//
//  DeletionViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 18/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class DeletionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(barButtonTouched))
        
        tableView.tableManagerDelegate = self // The delegate is optional. Set just if you want be notified what the row was deleted 
        
        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.setCanDelete(true)
            
            // Or you can pass the title for delete confirmation as parameter too
            // row.setCanDelete(true, titleForDeleteConfirmation: "Go away")
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }
    
    final func barButtonTouched() {
        tableView.editing = !tableView.editing
    }
    
}

extension DeletionViewController: TableManagerDelegate {
    
    func tableManagerDidDelete(row: Row, atIndexPath: NSIndexPath) {
        print("delete action: " + atIndexPath.debugDescription)
    }
    
}
