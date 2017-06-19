//
//  ActionsViewController.swift
//  TableManager Example
//
//  Created by Luis Filipe Campani on 6/19/17.
//  Copyright © 2017 Morbix. All rights reserved.
//

import Foundation
import UIKit
import TableManager

class ActionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Fake.basicData().forEach { element in
            let row = tableView.addRow()
            let update = UITableViewRowAction(style: .normal, title: "Editar") { action, index in
                print("Editar")
            }
            let delete = UITableViewRowAction(style: .default, title: "Excluir") { action, index in
                print("Excluir")
            }
            row.setActions([delete, update])

            row.setConfiguration { _, cell, _ in
                cell.textLabel?.text = element
            }
        }
    }
}

extension ActionsViewController: Screen {
    static func screenTitle() -> String {
        return "Actions"
    }
}
