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
    
    public var scrollViewDelegate: UIScrollViewDelegate? {
        set {
            self.tableManagerInstance().scrollViewDelegate = newValue
        }
        get{
            return self.tableManagerInstance().scrollViewDelegate
        }
    }
    
    // MARK: Methods
    
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
    
    /// Add a new section in the table. If no section is passed as parameter, a new empty section will be allocated and added in the table.
    public func addSection(section: Section? = nil) -> Section {
        return self.tableManagerInstance().addSection(section)
    }
    
    /// Add a new row in the table. A new section will be added if don't exist yet. If any row is passed as parameter, a new empty row will be allocated, added in the first section and returned.
    public func addRow(row: Row? = nil) -> Row {
        return self.tableManagerInstance().addRow(row)
    }
    
    /// Initializes a new row with identifier, add it in the table and returns it. A new section will be added if don't exist yet.
    public func addRow(identifier: String) -> Row {
        return self.tableManagerInstance().addRow(identifier)
    }
    
    /// Remove all sections
    public func clearSections() {
        self.tableManagerInstance().clearSections()
    }
    
    /// Remove all rows from the first section
    public func clearRows() {
        self.tableManagerInstance().clearRows()
    }
    
}
