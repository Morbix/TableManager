//
//  Row.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

public class Row {
    
    /// The cell identifier
    public let identifier: String
    
    /// Defines if it need be rendered or not when reload the table
    public var visible = true
    
    /// The object that can be used in the closure's impementation.
    public var object: AnyObject?
    
    /// The closure that will be called when the table request the cell.
    public var configuration: Configuration?
    
    /// The closure that will be called when the cell was selected.
    public var didSelect: DidSelect?
    
    /// Initializes a new Row
    public required init(withIdentifier identifier: String, visible: Bool = true, object: AnyObject? = nil) {
        self.identifier = identifier
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Set object that can be used in the closure's impementation.
    public func setObject(object: AnyObject) {
        self.object = object
    }
    
    /// Set closure that will be called when the table request the cell.
    public func setConfiguration(block: Configuration) {
        self.configuration = block
    }
    
    /// Set closure that will be called when the cell was selected.
    public func setDidSelect(block: DidSelect) {
        self.didSelect = block
    }
    
    public typealias Configuration = (row: Row, cell: UITableViewCell, indexPath: NSIndexPath) -> Void
    public typealias DidSelect = (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void
}
