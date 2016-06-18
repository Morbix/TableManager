//
//  SelectionViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 14/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class SelectionViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Fake.basicData().forEach { element in
            let row = tableView.addRow()
                
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
            
            row.setDidSelect { (row, tableView, indexPath) in
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                self.showAlert(element + " selected.")
            }
        }
        
    }

    final private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
}
