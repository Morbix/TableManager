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
    
    /// Defines if it needs to be showed in vertical scrollbar.
    open var indexTitle: String?
    
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
    
    /// Set section visibility
    @discardableResult
    open func setVisible(_ visible: Bool) -> Section {
        self.visible = visible
        return self
    }
    
    /// Set object that can be used in the closure's impementation.
    @discardableResult
    open func setObject(_ object: AnyObject) -> Section {
        self.object = object
        return self
    }
    
    /// Set indexTitle to be showed in vertical scrollbar.
    @discardableResult
    open func setIndexTitle(_ title: String) -> Section {
        self.indexTitle = title
        return self
    }
    
    /// Returns the Row by indexPath, includeAll parameter means it will include rows with visible=false too
    open func row(atIndex index: Int, includeAll: Bool = false) -> Row {
        let objects = includeAll ? rows : rowsToRender
        
        if objects.count > index {
            return objects[index]
        } else {
            return Row()
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
    @discardableResult
    open func clearRows() -> Section {
        rows.removeAll()
        return self
    }
    
    // MARK: Header Configuration
    
    /// Set the header using a closure that will be called when the table request a title
    @discardableResult
    open func setHeaderView(withDynamicText dynamicText: @escaping TitleForHeader) -> Section {
        titleForHeader = dynamicText
        return self
    }
    
    /// Set the header using a static title
    @discardableResult
    open func setHeaderView(withStaticText staticText: String) -> Section {
        setHeaderView { _,_,_  in
            return staticText
        }
        return self
    }
    
    /// Set the header using a closure that will be called when the table request a view
    @discardableResult
    open func setHeaderView(withDynamicView dynamicView: @escaping ViewForHeader) -> Section {
        viewForHeader = dynamicView
        return self
    }
    
    /// Set the header using a static view
    @discardableResult
    open func setHeaderView(withStaticView staticView: UIView) -> Section {
        setHeaderView { _,_,_  in
            return staticView
        }
        return self
    }
    
    /// Set the header's height using a closure that will be called when the table request the a height
    @discardableResult
    open func setHeaderHeight(withDynamicHeight dynamicHeight: @escaping HeightForHeader) -> Section {
        heightForHeader = dynamicHeight
        return self
    }
    
    /// Set the header's height using a static height
    @discardableResult
    open func setHeaderHeight(withStaticHeight staticHeight: Double) -> Section {
        setHeaderHeight { _,_,_  in
            return staticHeight
        }
        return self
    }
    
    public typealias HeightForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> Double
    public typealias ViewForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> UIView
    public typealias TitleForHeader = (_ section: Section, _ tableView: UITableView, _ index: Int) -> String
    
    // MARK: Footer Configuration
    
    /// Set the footer using a closure that will be called when the table request a title
    @discardableResult
    open func setFooterView(withDynamicText dynamicText: @escaping TitleForFooter) -> Section {
        titleForFooter = dynamicText
        return self
    }
    
    /// Set the footer using a static title
    @discardableResult
    open func setFooterView(withStaticText staticText: String) -> Section {
        setFooterView { _,_,_  in
            return staticText
        }
        return self
    }
    
    /// Set the footer using a closure that will be called when the table request a view
    @discardableResult
    open func setFooterView(withDynamicView dynamicView: @escaping ViewForFooter) -> Section {
        viewForFooter = dynamicView
        return self
    }
    
    /// Set the footer using a static view
    @discardableResult
    open func setFooterView(withStaticView staticView: UIView) -> Section {
        setFooterView { _,_,_  in
            return staticView
        }
        return self
    }
    
    /// Set the footer's height using a closure that will be called when the table request the a height
    @discardableResult
    open func setFooterHeight(withDynamicHeight dynamicHeight: @escaping HeightForFooter) -> Section {
        heightForFooter = dynamicHeight
        return self
    }
    
    /// Set the footer's height using a static height
    @discardableResult
    open func setFooterHeight(withStaticHeight staticHeight: Double) -> Section {
        setFooterHeight { _,_,_  in
            return staticHeight
        }
        return self
    }
    
    public typealias HeightForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> Double
    public typealias ViewForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> UIView
    public typealias TitleForFooter = (_ section: Section, _ tableView: UITableView, _ index: Int) -> String
    
}

public func == (lhs: Section, rhs: Section) -> Bool {
    return lhs.id == rhs.id
}
