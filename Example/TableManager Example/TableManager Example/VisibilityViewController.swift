//
//  VisibilityViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 14/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class VisibilityViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Fake.sectionsAndRowsData().enumerated().forEach { index, element in
            let newSection = tableView.addSection()
            
            newSection.visible = (index % 2 == 0) ? true : false
            
            element.rows.enumerated().forEach { index, description in
                
                let newRow = newSection.addRow()
                    
                newRow.setConfiguration { (row, cell, indexPath) in
                    cell.textLabel?.text = element.section + " - " + description
                }
                
                newRow.visible = (index % 2 == 0) ? true : false
            }
        }
        
        tableView.reloadData()
    }

}
