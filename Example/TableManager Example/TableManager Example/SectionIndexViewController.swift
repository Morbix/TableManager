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
        
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        
        alphabet.forEach { letter in
            let newSection = tableView.addSection()
                .setIndexTitle(letter)
                .setHeaderView(withStaticText: letter)
                .setHeaderHeight(withStaticHeight: 20)

            Fake.basicData().forEach { element in
                newSection.addRow().setConfiguration { _, cell, _ in
                    cell.textLabel?.text = element
                }
            }
        }
    }
}

extension SectionIndexViewController: Screen {
    static func screenTitle() -> String {
        return "Index Titles"
    }
}
