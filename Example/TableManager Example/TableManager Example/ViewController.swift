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
                
        let section = Section()
        tableView.sections.append(section)
        
        section.setHeaderHeight(withStaticHeight: 28.0)
        section.setHeaderView(withStaticText: "Header Text")
        
        section.setFooterHeight(withStaticHeight: 28.0)
        section.setFooterView(withStaticText: "Footer Text")
        
        let data = ["Row A", "Row B", "Row C", "Row D", "Row E", "Row F", "Row G", "Row H", "Row I", "Row J", "Row K", "Row L", "Row M", "Row N", "Row O", "Row P", "Row Q", "Row R", "Row S", "Row T", "Row U", "Row V", "Row W", "Row X", "Row Y", "Row Z"]
        
        data.forEach {
            let row = Row(withIdentifier: "CellBasic", object: $0)
            
            row.setConfiguration { (row, cell, indexPath) in
                if let text = row.object as? String {
                    cell.textLabel?.text = text
                }
            }
            
            row.setDidSelect { (row, tableView, indexPath) in
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
                
                if let text = row.object as? String {
                    print(text + " selected")
                }
            }
            
            section.rows.append(row)
        }
        
        tableView.reloadData()
    }

}
