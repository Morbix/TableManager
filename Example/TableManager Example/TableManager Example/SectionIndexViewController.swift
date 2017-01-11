//
//  SectionIndexViewController.swift
//  TableManager Example
//
//  Created by Uriel Battanoli on 1/10/17.
//  Copyright © 2017 Morbix. All rights reserved.
//

import UIKit
import TableManager

class SectionIndexViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        
        alphabet.forEach { letter in
            let newSection = tableView.addSection().setIndexTitle(letter)
            
            Fake.basicData().forEach { element in
                let newRow = newSection.addRow()
                
                newRow.setConfiguration({ (row, cell, indexPath) in
                    cell.textLabel?.text = letter + " - " + element
                })
            }
        }
        
        tableView.reloadData()
    }
}

extension SectionIndexViewController: Screen {
    static func screenTitle() -> String {
        return "Index Titles"
    }
}
