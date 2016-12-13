//
//  CustomCellViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 14/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class CustomCellViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let identifier = "CellCustomA"
        
        tableView.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44

        Fake.sectionsAndRowsData().forEach { element in
            
            let newSection = tableView.addSection()
            
            element.rows.forEach { description in
                
                let newRow = newSection.addRow(identifier) // Don't forget to use a identifier when you use a custom cell
                
                newRow.setConfiguration { (row, cell, indexPath) in
                    if let cell = cell as? CellCustomA {
                        cell.titleContent.text = element.section
                        cell.subtitleContent.text = description
                    }
                }
            }
        }
        
        tableView.reloadData()
    }

}
