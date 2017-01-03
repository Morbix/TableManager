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
            let newSection = tableView.addSection().setVisible((index % 2 == 0) ? true : false)
            
            element.rows.enumerated().forEach { index, description in
                let newRow = newSection.addRow().setVisible((index % 2 == 0) ? true : false)
                    
                newRow.setConfiguration { (row, cell, indexPath) in
                    cell.textLabel?.text = element.section + " - " + description
                }
            }
        }
        
        tableView.reloadData()
    }

}

extension VisibilityViewController: Screen {
    static func screenTitle() -> String {
        return "Visibility"
    }
}
