//
//  ViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 10/01/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getExamples().forEach { (title, didSelect) in
            
            let row = tableView.addRow("CellBasic")
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = title
                
                if let _ = row.didSelect {
                    cell.textLabel?.font = UIFont.systemFontOfSize(16)
                    cell.textLabel?.textAlignment = .Left
                    cell.accessoryType = .DisclosureIndicator
                    cell.selectionStyle = .Default
                } else {
                    cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
                    cell.textLabel?.textAlignment = .Center
                    cell.accessoryType = .None
                    cell.selectionStyle = .None
                }
            }
            
            row.didSelect = didSelect
        }
        
        tableView.reloadData()
    }
    
    // MARK: Methodos
    
    final private func getExamples() -> [(String, Row.DidSelect?)] {
        return [
            ("Basic Usage", navigateToBasicUsage()),
            ("Complex Usage", navigateToComplexUsage()),
            ("Documentation", nil)
        ]
    }

    // MARK: Actions
    
    final private func navigateToBasicUsage() -> Row.DidSelect {
        return { row, tableView, indexPath in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.navigationController?.pushViewController(BasicUsageViewController(), animated: true)
        }
    }
    
    final private func navigateToComplexUsage() -> Row.DidSelect {
        return { row, tableView, indexPath in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        }
    }
}
