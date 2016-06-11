//
//  TableViewExtension.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import UIKit

internal let instanceKey = "tableManagerInstance"

public extension UITableView {
    
    public func tableManagerInstance() -> TableManager {
        guard let tableManager = self.layer.valueForKey(instanceKey) as? TableManager else {
            let tableManager = TableManager(tableView: self)
            self.layer.setValue(tableManager, forKey: instanceKey)
            return tableManager
        }
        return tableManager
    }
    
    public var sections: [Section] {
        set {
            self.tableManagerInstance().sections = newValue
        }
        
        get {
            return self.tableManagerInstance().sections
        }
    }
    
    public var visibleSections: [Section] {
        return self.tableManagerInstance().visibleSections
    }
    
    public func row(atIndexPath indexPath: NSIndexPath) -> Row {
        return self.tableManagerInstance().row(atIndexPath: indexPath)
    }
    
    public func section(atIndex index: Int) -> Section {
        return self.tableManagerInstance().section(atIndex: index)
    }
    
    public func selectedRow() -> Row? {
        return self.tableManagerInstance().selectedRow()
    }
    
    public func displayedRows() -> [Row]? {
        return self.tableManagerInstance().displayedRows()
    }
    
}
