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
    
    /// The instance of TableManager. A new one will be created if not exist.
    public func tableManagerInstance() -> TableManager {
        guard let tableManager = self.layer.valueForKey(instanceKey) as? TableManager else {
            let tableManager = TableManager(tableView: self)
            self.layer.setValue(tableManager, forKey: instanceKey)
            return tableManager
        }
        return tableManager
    }
    
    /// All sections added to the table
    public var sections: [Section] {
        set {
            self.tableManagerInstance().sections = newValue
        }
        
        get {
            return self.tableManagerInstance().sections
        }
    }
    
    /// Sections with `visible=true`
    public var sectionsToRender: [Section] {
        return self.tableManagerInstance().sectionsToRender
    }
    
    /// Get the Row by indexPath (only Rows with `visible=true`)
    public func row(atIndexPath indexPath: NSIndexPath) -> Row {
        return self.tableManagerInstance().row(atIndexPath: indexPath)
    }
    
    /// Get the Section by indexPath (only Section with `visible=true`)
    public func section(atIndex index: Int) -> Section {
        return self.tableManagerInstance().section(atIndex: index)
    }
    
    /// If exist, return the Row that correspond the selected cell
    public func selectedRow() -> Row? {
        return self.tableManagerInstance().selectedRow()
    }
    
    /// If exist, return the Rows that are appearing to the user in the table
    public func visibleRows() -> [Row]? {
        return self.tableManagerInstance().visibleRows()
    }
    
}
