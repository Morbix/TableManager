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

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check selected row", style: .Plain, target: self, action: #selector(barButtonTouched))
        
        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.object = element

            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }
    
    final private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    final func barButtonTouched() {
        if let selectedRow = tableView.selectedRow(), value = selectedRow.object as? String {
            showAlert(value)
        } else {
            showAlert("no one")
        }
    }
    
}
