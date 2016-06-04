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
    
    lazy var tableManager: TableManager = TableManager(tableView: self.tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let section = Section()
        tableManager.sections.append(section)
        
        let data = ["Basic Usage", "Row Selection", "Sections & Rows Visibility", "Custom Cells"]
        
        data.forEach {
            let row = Row(withIdentifier: "CellBasic", object: $0)
            
            row.setConfiguration { (row, cell, indexPath) in
                if let text = row.object as? String {
                    cell.textLabel?.text = text
                }
            }
            
            row.setDidSelect { (row, tableView, indexPath) in
                if let text = row.object as? String {
                    print(text + " selected")
                }
            }
            
            section.rows.append(row)
        }
        
        //6 - Reloading table
        tableManager.reloadData()
    }

}
