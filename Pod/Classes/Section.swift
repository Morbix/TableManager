//
//  Section.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

public class Section {
    
    /// Defines if it need be rendered or not when reload the table
    public var visible = true
    
    /// The object that can be used in the closure's impementation.
    public var object: AnyObject?
    
    /// The rows added to this section
    public var rows = [Row]()
    
    /// The rows added to this section and with `visible=true`
    public var rowsToRender: [Row] {
        return rows.filter {
            $0.visible
        }
    }
    
    /// The closure that will be called when the table request the header's height
    public var heightForHeader: HeightForHeader?
    
    /// The closure that will be called when the table request the header's title
    public var titleForHeader: TitleForHeader?
    
    /// The closure that will be called when the table request the header's view
    public var viewForHeader: ViewForHeader?
    
    /// The closure that will be called when the table request the footer's height
    public var heightForFooter: HeightForFooter?
    
    /// The closure that will be called when the table request the footer's title
    public var titleForFooter: TitleForFooter?
    
    /// The closure that will be called when the table request the footer's view
    public var viewForFooter: ViewForFooter?
    
    /// Initializes a new Section. All parameters are optionals.
    public required init(visible: Bool = true, object: AnyObject? = nil) {
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    /// Returns the Row by indexPath, includeAll parameter means it will include rows with visible=false too
    public func row(atIndex index: Int, includeAll: Bool = false) -> Row {
        let objects = includeAll ? rows : rowsToRender
        
        if objects.count > index {
            return objects[index]
        } else {
            return addRow()
        }
    }
    
    /// Set object that can be used in the closure's impementation.
    public func setObject(object: AnyObject) {
        self.object = object
    }
    
    /// Add a new row in the section. If any row is passed as parameter, a new empty row will be allocated, added in the section and returned.
    public func addRow(row: Row? = nil) -> Row {
        let newRow = row ?? Row()
        rows.append(newRow)
        return newRow
    }
    
    /// Initializes a new row with identifier, add it in the section and returns it.
    public func addRow(identifier: String) -> Row {
        let newRow = Row(identifier: identifier)
        rows.append(newRow)
        return newRow
    }
    
    /// Remove all rows
    public func clearRows() {
        rows.removeAll()
    }
    
    // MARK: Header Configuration
    
    /// Set the header using a closure that will be called when the table request a title
    public func setHeaderView(withDynamicText dynamicText: TitleForHeader) {
        titleForHeader = dynamicText
    }
    
    /// Set the header using a static title
    public func setHeaderView(withStaticText staticText: String) {
        setHeaderView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    /// Set the header using a closure that will be called when the table request a view
    public func setHeaderView(withDynamicView dynamicView: ViewForHeader) {
        viewForHeader = dynamicView
    }
    
    
    /// Set the header using a static view
    public func setHeaderView(withStaticView staticView: UIView) {
        setHeaderView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    /// Set the header's height using a closure that will be called when the table request the a height
    public func setHeaderHeight(withDynamicHeight dynamicHeight: HeightForHeader) {
        heightForHeader = dynamicHeight
    }
    
    /// Set the header's height using a static height
    public func setHeaderHeight(withStaticHeight staticHeight: Double) {
        setHeaderHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForHeader = (section: Section, tableView: UITableView, index: Int) -> Double
    public typealias ViewForHeader = (section: Section, tableView: UITableView, index: Int) -> UIView
    public typealias TitleForHeader = (section: Section, tableView: UITableView, index: Int) -> String
    
    // MARK: Footer Configuration
    
    /// Set the footer using a closure that will be called when the table request a title
    public func setFooterView(withDynamicText dynamicText: TitleForFooter) {
        titleForFooter = dynamicText
    }
    
    /// Set the footer using a static title
    public func setFooterView(withStaticText staticText: String) {
        setFooterView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    /// Set the footer using a closure that will be called when the table request a view
    public func setFooterView(withDynamicView dynamicView: ViewForFooter) {
        viewForFooter = dynamicView
    }
    
    /// Set the footer using a static view
    public func setFooterView(withStaticView staticView: UIView) {
        setFooterView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    /// Set the footer's height using a closure that will be called when the table request the a height
    public func setFooterHeight(withDynamicHeight dynamicHeight: HeightForFooter) {
        heightForFooter = dynamicHeight
    }
    
    /// Set the footer's height using a static height
    public func setFooterHeight(withStaticHeight staticHeight: Double) {
        setFooterHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForFooter = (section: Section, tableView: UITableView, index: Int) -> Double
    public typealias ViewForFooter = (section: Section, tableView: UITableView, index: Int) -> UIView
    public typealias TitleForFooter = (section: Section, tableView: UITableView, index: Int) -> String
    
}
