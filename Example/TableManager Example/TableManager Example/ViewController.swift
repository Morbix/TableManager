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
        
        let examples = [
            BasicUsageViewController.self,
            VisibilityViewController.self,
            CustomCellViewController.self,
            SelectionViewController.self,
            DragAndDropViewController.self,
            DeletionViewController.self,
            SelectedRowViewController.self,
            VisibleRowsViewController.self,
            ScrollViewDelegateViewController.self,
            SpacesTableViewController.self
        ] as [UIViewController.Type]
        
        examples.forEach { screen in
            tableView.addRow()
                .setDidSelect(self.navigate(to: screen))
                .setConfiguration { _, cell, _ in
                    cell.textLabel?.text = (screen as? Screen.Type)?.screenTitle()
                }
        }
        
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    final fileprivate func navigate(to viewController: UIViewController.Type) -> Row.DidSelect {
        return { row, tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(viewController.init(), animated: true)
        }
    }

}

extension UIViewController {
    final func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

protocol Screen {
    static func screenTitle() -> String
}
