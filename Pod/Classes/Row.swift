//
//  Row.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

open class Row: Equatable {
    
    var id = NSObject()

    /// The cell identifier
    open var identifier: String?
    
    /// Defines if it need be rendered or not when reload the table.
    open var visible = true
    
    var editingStyle = UITableViewCellEditingStyle.none
    var movable = false
    var deleteConfirmation: String?
    var actions: [UITableViewRowAction]?
    
    /// Read only property that indicate if the row is movable.
    open var canMove: Bool {
        return movable
    }
    
    /// Read only property that indicate if the row is deletable.
    open var canDelete: Bool {
        return editingStyle == .delete
    }
    
    /// Read only property that indicate if the row is insertable. (not implemented yet)
    fileprivate var canInsert: Bool {
        return editingStyle == .insert
    }
    
    /// Read only property that indicate if the row is editable. Will be true if the row can perform any of this actions: move, delete or insert.
    open var canEdit: Bool {
        if let actions = actions {
            return !actions.isEmpty
        }
        return canMove || canDelete || canInsert
    }
    
    /// The object that can be used in the closure's impementation.
    open var object: AnyObject?
    
    /// The closure that will be called when the table request the cell.
    open var configuration: Configuration?
    
    /// The closure that will be called when the cell was selected.
    open var didSelect: DidSelect?
    
    /// The closure that will be called when the cell is going to be displayed.
    open var willDisplay: WillDisplay?
    
    /// The closure that will be called when the table request the row's height.
    open var heightForRow: HeightForRow?
    
    weak var tableViewReference: UITableView?
    
    var indexPathReference: IndexPath?
    
    open weak var cell: UITableViewCell?
    
    /// Initializes a new Row. All parameters are optionals.
    public required init(identifier: String? = nil, visible: Bool = true, object: AnyObject? = nil) {
        self.identifier = identifier
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Set row visibility
    @discardableResult
    open func setVisible(_ visible: Bool) -> Row {
        self.visible = visible
        return self
    }
    
    /// Set a identifier to use a custom cell
    @discardableResult
    open func setIdentifier(_ identifier: String) -> Row {
        self.identifier = identifier
        return self
    }
    
    /// Set object that can be used in the closure's impementation.
    @discardableResult
    open func setObject(_ object: AnyObject) -> Row {
        self.object = object
        return self
    }
    
    /// Define if the row can be moved
    @discardableResult
    open func setCanMove(_ movable: Bool) -> Row {
        self.movable = movable
        return self
    }
    
    /// Define if the row can be deleted
    @discardableResult
    open func setCanDelete(_ deletable: Bool, titleForDeleteConfirmation: String? = nil) -> Row {
        self.editingStyle = deletable ? .delete : .none
        self.deleteConfirmation = titleForDeleteConfirmation
        return self
    }
    
    /// Define if the row can be inserted (not implemented yet)
    @discardableResult
    fileprivate func setCanInsert(_ insertable: Bool) -> Row {
        self.editingStyle = insertable ? .insert : .none
        return self
    }

    /// Define if the row have a custom swipe
    @discardableResult
    open func setActions(_ actions: [UITableViewRowAction]) -> Row {
        self.actions = actions
        self.editingStyle = .delete
        return self
    }

    /// Clear row actions
    @discardableResult
    open func clearActions() -> Row {
        self.actions = nil
        self.editingStyle = .none
        return self
    }
    
    /// Set closure that will be called when the table request the cell.
    @discardableResult
    open func setConfiguration(_ block: @escaping Configuration) -> Row {
        self.configuration = block
        return self
    }
    
    /// Set closure that will be called when the cell was selected.
    @discardableResult
    open func setDidSelect(_ block: @escaping DidSelect) -> Row {
        self.didSelect = block
        return self
    }
    
    /// Set closure that will be called when the cell is going to be displayed.
    @discardableResult
    open func setWillDisplay(_ block: @escaping WillDisplay) -> Row {
        self.willDisplay = block
        return self
    }
    
    /// Set the row's height using a closure that will be called when the table request the a height
    @discardableResult
    open func setHeight(withDynamicHeight dynamicHeight: @escaping HeightForRow) -> Row {
        heightForRow = dynamicHeight
        return self
    }
    
    /// Set the row's height to automatic
    @discardableResult
    open func setHeightAutomatic() -> Row {
        setHeight(withStaticHeight: Double(UITableViewAutomaticDimension))
        return self
    }
    
    /// Set the row's height using a static height
    @discardableResult
    open func setHeight(withStaticHeight staticHeight: Double) -> Row {
        setHeight { _,_,_  -> Double in
            return staticHeight
        }
        return self
    }
    
    /// Get the row's height after it has been appeared in the screen
    /// Return`s zero if the visibility is false
    open func getHeight() -> Double {
        if !visible {
            return 0
        }
        
        guard let heightForRow = heightForRow else {
            return defaultCellHeight
        }
        
        guard let tableView = tableViewReference else {
            return defaultCellHeight
        }
        
        guard let indexPath = indexPathReference else {
            return defaultCellHeight
        }
        
        let height = heightForRow(self, tableView, indexPath)
        
        if height > Double(UITableViewAutomaticDimension) {
            return height
        }
        
        guard let contentHeight = self.cell?.contentView.frame.height else {
            return defaultCellHeight
        }
        
        return Double(contentHeight)
    }

    public typealias HeightForRow = (_ row: Row, _ tableView: UITableView, _ indexPath: IndexPath) -> Double
    public typealias Configuration = (_ row: Row, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void
    public typealias DidSelect = (_ row: Row, _ tableView: UITableView, _ indexPath: IndexPath) -> Void
    public typealias WillDisplay = (_ row: Row, _ tableView: UITableView, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void
}

public func == (lhs: Row, rhs: Row) -> Bool {
    return lhs.id == rhs.id
}
