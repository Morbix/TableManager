//
//  VisibleRowsViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 19/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit

class VisibleRowsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check visible rows", style: .plain, target: self, action: #selector(barButtonTouched))
        
        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            
            row.object = element as AnyObject?
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc final func barButtonTouched() {
        if let visibleRows = tableView.visibleRows() {
            let message: String = visibleRows.reduce("") { current, row in
                if let object = row.object as? String {
                    return current + "\n " + object
                }
                
                return current
            }
            
            showAlert(message)
        }
    }
    
}

extension VisibleRowsViewController: Screen {
    static func screenTitle() -> String {
        return "Visible Rows"
    }
}
