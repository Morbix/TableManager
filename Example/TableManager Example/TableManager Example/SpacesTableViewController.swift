//
//  SpacesTableViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 21/12/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit

class SpacesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        
        tableView.addSpace(height: Double(view.bounds.height)/2 - 148)
        
        tableView.addRow().setConfiguration { row, cell, indexPath in
            cell.textLabel?.text = "First Cell"
        }
        
        tableView.addSpace(bgColor: UIColor.lightGray)
        
        tableView.addRow().setConfiguration { row, cell, indexPath in
            cell.textLabel?.text = "Second Cell"
        }
        
        tableView.addSpace(bgColor: UIColor.lightGray)
        
        tableView.addRow().setConfiguration { row, cell, indexPath in
            cell.textLabel?.text = "Third Cell"
        }
    }

}

extension SpacesViewController: Screen {
    static func screenTitle() -> String {
        return "Space Rows"
    }
}
