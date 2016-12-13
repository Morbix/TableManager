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
        return canMove || canDelete || canInsert
    }
    
    /// The object that can be used in the closure's impementation.
    open var object: AnyObject?
    
    /// The closure that will be called when the table request the cell.
    open var configuration: Configuration?
    
    /// The closure that will be called when the cell was selected.
    open var didSelect: DidSelect?
    
    /// The closure that will be called when the table request the row's height.
    open var heightForRow: HeightForRow?
    
    /// Initializes a new Row. All parameters are optionals.
    public required init(identifier: String? = nil, visible: Bool = true, object: AnyObject? = nil) {
        self.identifier = identifier
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Set a identifier to use a custom cell
    open func setIdentifier(_ identifier: String) {
        self.identifier = identifier
    }
    
    /// Set object that can be used in the closure's impementation.
    open func setObject(_ object: AnyObject) {
        self.object = object
    }
    
    /// Define if the row can be moved
    open func setCanMove(_ movable: Bool) {
        self.movable = movable
    }
    
    /// Define if the row can be deleted
    open func setCanDelete(_ deletable: Bool, titleForDeleteConfirmation: String? = nil) {
        self.editingStyle = deletable ? .delete : .none
        self.deleteConfirmation = titleForDeleteConfirmation
    }
    
    /// Define if the row can be inserted (not implemented yet)
    fileprivate func setCanInsert(_ insertable: Bool) {
        self.editingStyle = insertable ? .insert : .none
    }
    
    /// Set closure that will be called when the table request the cell.
    open func setConfiguration(_ block: @escaping Configuration) {
        self.configuration = block
    }
    
    /// Set closure that will be called when the cell was selected.
    open func setDidSelect(_ block: @escaping DidSelect) {
        self.didSelect = block
    }
    
    /// Set the row's height using a closure that will be called when the table request the a height
    open func setHeight(withDynamicHeight dynamicHeight: @escaping HeightForRow) {
        heightForRow = dynamicHeight
    }
    
    /// Set the row's height using a static height
    open func setHeight(withStaticHeight staticHeight: Double) {
        setHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForRow = (_ row: Row, _ tableView: UITableView, _ index: Int) -> Double
    public typealias Configuration = (_ row: Row, _ cell: UITableViewCell, _ indexPath: IndexPath) -> Void
    public typealias DidSelect = (_ row: Row, _ tableView: UITableView, _ indexPath: IndexPath) -> Void
}

public func ==(lhs: Row, rhs: Row) -> Bool {
    return lhs.id == rhs.id
}
