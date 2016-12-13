//
//  SelectedRowViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 19/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit

class SelectedRowViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check selected row", style: .plain, target: self, action: #selector(barButtonTouched))
        
        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.object = element as AnyObject?

            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }
    
    final func barButtonTouched() {
        if let selectedRow = tableView.selectedRow(), let value = selectedRow.object as? String {
            showAlert(value)
        } else {
            showAlert("no one")
        }
    }
    
}
