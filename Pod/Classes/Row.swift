//
//  Row.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

public class Row {
    
    public let identifier: String
    public var visible = true
    public var object: AnyObject?
    
    public var configuration: Configuration?
    public var didSelect: DidSelect?
    
    public required init(withIdentifier identifier: String, visible: Bool = true, object: AnyObject? = nil) {
        self.identifier = identifier
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    public func setObject(object: AnyObject) {
        self.object = object
    }
    
    public func setConfiguration(block: Configuration) {
        self.configuration = block
    }
    
    public func setDidSelect(block: DidSelect) {
        self.didSelect = block
    }
    
    public typealias Configuration = (row: Row, cell: UITableViewCell, indexPath: NSIndexPath) -> Void
    public typealias DidSelect = (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void
}
