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
            Screen.SelectedRow,
            Screen.VisibleRows,
            Screen.ScrollViewDelegate
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
    
    final fileprivate func navigateTo(_ screen: Screen) -> Row.DidSelect {
        return { row, tableView, indexPath in
            tableView.deselectRow(at: indexPath, animated: true)
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
    case VisibleRows = "Visible Rows"
    case ScrollViewDelegate = "ScrollView Delegate "
    
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
        case .VisibleRows:
            return VisibleRowsViewController()
        case .ScrollViewDelegate:
            return ScrollViewDelegateViewController()
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
