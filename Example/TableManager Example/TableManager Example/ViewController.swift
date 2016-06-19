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
            Screen.BasicUsage,
            Screen.Visibility,
            Screen.CustomCell,
            Screen.Selection,
            Screen.DragAndDrop,
            Screen.Deletion,
            Screen.SelectedRow
        ]
        
        examples.forEach { screen in
            let row = tableView.addRow("CellBasic")
            
            row.setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = screen.rawValue
            }
            
            row.didSelect = self.navigateTo(screen)
        }
        
        tableView.reloadData()
    }
    
    // MARK: Actions
    
    final private func navigateTo(screen: Screen) -> Row.DidSelect {
        return { row, tableView, indexPath in
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.navigationController?.pushViewController(screen.getViewController(), animated: true)
        }
    }

}

private enum Screen: String {
    case BasicUsage = "Basic Usage"
    case ComplexUsage = "Complex Usage"
    case Visibility = "Visibility"
    case CustomCell = "Custom Cell"
    case Selection = "Selection"
    case DragAndDrop = "Drag & Drop"
    case Deletion = "Deletion"
    case SelectedRow = "Selected Row"
    
    func getViewController() -> UIViewController {
        switch self {
        case .BasicUsage:
            return BasicUsageViewController()
        case .ComplexUsage:
            return UIViewController()
        case .Visibility:
            return VisibilityViewController()
        case .CustomCell:
            return CustomCellViewController()
        case .Selection:
            return SelectionViewController()
        case .DragAndDrop:
            return DragAndDropViewController()
        case .Deletion:
            return DeletionViewController()
        case .SelectedRow:
            return SelectedRowViewController()
        }
    }
}
