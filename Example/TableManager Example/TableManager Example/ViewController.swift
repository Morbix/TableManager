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
        
        let section = tableView.addSection()
    
        let data = (1...1_000).map { "Row \($0)" }
        
        data.forEach { element in
            let row = section.addRow()
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
            
            row.setDidSelect { (row, tableView, indexPath) in
                print(element + " selected")
            }
        }
        
        tableView.reloadData()
    }

}
