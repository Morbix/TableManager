//
//  Section.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

open class Section: Equatable {
    
    var id = NSObject()
    
    /// Defines if it need be rendered or not when reload the table
    open var visible = true
    
    /// The object that can be used in the closure's impementation.
    open var object: AnyObject?
    
    /// The rows added to this section
    open var rows = [Row]()
    
    /// The rows added to this section and with `visible=true`
    open var rowsToRender: [Row] {
        return rows.filter {
            $0.visible
        }
    }
    
    /// The closure that will be called when the table request the header's height
    open var heightForHeader: HeightForHeader?
    
    /// The closure that will be called when the table request the header's title
    open var titleForHeader: TitleForHeader?
    
    /// The closure that will be called when the table request the header's view
    open var viewForHeader: ViewForHeader?
    
    /// The closure that will be called when the table request the footer's height
    open var heightForFooter: HeightForFooter?
    
    /// The closure that will be called when the table request the footer's title
    open var titleForFooter: TitleForFooter?
    
    /// The closure that will be called when the table request the footer's view
    open var viewForFooter: ViewForFooter?
    
    /// Initializes a new Section. All parameters are optionals.
    public required init(visible: Bool = true, object: AnyObject? = nil) {
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Set object that can be used in the closure's impementation.
    open func setObject(_ object: AnyObject) {
        self.object = object
    }
    
    /// Returns the Row by indexPath, includeAll parameter means it will include rows with visible=false too
    open func row(atIndex index: Int, includeAll: Bool = false) -> Row {
        let objects = includeAll ? rows : rowsToRender
        
        if objects.count > index {
            return objects[index]
        } else {
            return addRow()
        }
    }
    
    /// Returns the index of the Row if exist
    open func index(forRow row: Row, includeAll: Bool = false) -> Int? {
        let objects = includeAll ? rows : rowsToRender
        
        return objects.index {
            $0 == row
        }
    }
    
    /// Add a new row in the section. If any row is passed as parameter, a new empty row will be allocated, added in the section and returned.
    @discardableResult
    open func addRow(_ row: Row? = nil) -> Row {
        let newRow = row ?? Row()
        if index(forRow: newRow, includeAll: true) == nil {
            rows.append(newRow)
        }
        return newRow
    }
    
    /// Initializes a new row with identifier, add it in the section and returns it.
    @discardableResult
    open func addRow(_ identifier: String) -> Row {
        return addRow(Row(identifier: identifier))
    }
    
    /// Remove all rows
    open func clearRows() {
        rows.removeAll()
    }
    
    // MARK: Header Configuration
    
    /// Set the header using a closure that will be called when the table request a title
    open func setHeaderView(withDynamicText dynamicText: @escaping TitleForHeader) {
        titleForHeader = dynamicText
    }
    
    /// Set the header using a static title
    open func setHeaderView(withStaticText staticText: String) {
        setHeaderView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    /// Set the header using a closure that will be called when the table request a view
    open func setHeaderView(withDynamicView dynamicView: @escaping ViewForHeader) {
        viewForHeader = dynamicView
    }
    
    
    /// Set the header using a static view
    open func setHeaderView(withStaticView staticView: UIView) {
        setHeaderView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    /// Set the header's height using a closure that will be called when the table request the a height
    open func setHeaderHeight(withDynamicHeight dynamicHeight: @escaping HeightForHeader) {
        heightForHeader = dynamicHeight
    }
    
    /// Set the header's height using a static height
    open func setHeaderHeight(withStaticHeight staticHeight: Double) {
        setHeaderHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> Double
    public typealias ViewForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> UIView
    public typealias TitleForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> String
    
    // MARK: Footer Configuration
    
    /// Set the footer using a closure that will be called when the table request a title
    open func setFooterView(withDynamicText dynamicText: @escaping TitleForFooter) {
        titleForFooter = dynamicText
    }
    
    /// Set the footer using a static title
    open func setFooterView(withStaticText staticText: String) {
        setFooterView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    /// Set the footer using a closure that will be called when the table request a view
    open func setFooterView(withDynamicView dynamicView: @escaping ViewForFooter) {
        viewForFooter = dynamicView
    }
    
    /// Set the footer using a static view
    open func setFooterView(withStaticView staticView: UIView) {
        setFooterView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    /// Set the footer's height using a closure that will be called when the table request the a height
    open func setFooterHeight(withDynamicHeight dynamicHeight: @escaping HeightForFooter) {
        heightForFooter = dynamicHeight
    }
    
    /// Set the footer's height using a static height
    open func setFooterHeight(withStaticHeight staticHeight: Double) {
        setFooterHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> Double
    public typealias ViewForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> UIView
    public typealias TitleForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> String
    
}

public func ==(lhs: Section, rhs: Section) -> Bool {
    return lhs.id == rhs.id
}
