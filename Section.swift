//
//  Section.swift
//  Pods
//
//  Created by Henrique Morbin on 11/06/16.
//
//

import Foundation

public class Section {
    
    public var visible = true
    public var object: AnyObject?
    public var rows = [Row]()
    public var visibleRows: [Row] {
        return rows.filter {
            $0.visible
        }
    }
    
    public var heightForHeader: HeightForHeader?
    public var titleForHeader: TitleForHeader?
    public var viewForHeader: ViewForHeader?
    public var heightForFooter: HeightForFooter?
    public var titleForFooter: TitleForFooter?
    public var viewForFooter: ViewForFooter?
    
    public required init(visible: Bool = true, object: AnyObject? = nil) {
        self.visible = visible
        self.object = object
    }
    
    // MARK: Methods
    
    public func row(atIndex index: Int) -> Row {
        if visibleRows.count > index {
            return visibleRows[index]
        } else {
            let row = Row(withIdentifier: defaultCellIdentifier)
            rows.append(row)
            return row
        }
    }
    
    public func setObject(object: AnyObject) {
        self.object = object
    }
    
    // MARK: Header Configuration
    
    public func setHeaderView(withDynamicText dynamicText: TitleForHeader) {
        titleForHeader = dynamicText
    }
    
    public func setHeaderView(withStaticText staticText: String) {
        setHeaderView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    public func setHeaderView(withDynamicView dynamicView: ViewForHeader) {
        viewForHeader = dynamicView
    }
    
    public func setHeaderView(withStaticView staticView: UIView) {
        setHeaderView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    public func setHeaderHeight(withDynamicHeight dynamicHeight: HeightForHeader) {
        heightForHeader = dynamicHeight
    }
    
    public func setHeaderHeight(withStaticHeight staticHeight: Double) {
        setHeaderHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForHeader = (section: Section, tableView: UITableView, index: Int) -> Double
    public typealias ViewForHeader = (section: Section, tableView: UITableView, index: Int) -> UIView
    public typealias TitleForHeader = (section: Section, tableView: UITableView, index: Int) -> String
    
    // MARK: Footer Configuration
    
    public func setFooterView(withDynamicText dynamicText: TitleForFooter) {
        titleForFooter = dynamicText
    }
    
    public func setFooterView(withStaticText staticText: String) {
        setFooterView { (section, tableView, index) -> String in
            return staticText
        }
    }
    
    public func setFooterView(withDynamicView dynamicView: ViewForFooter) {
        viewForFooter = dynamicView
    }
    
    public func setFooterView(withStaticView staticView: UIView) {
        setFooterView { (section, tableView, index) -> UIView in
            return staticView
        }
    }
    
    public func setFooterHeight(withDynamicHeight dynamicHeight: HeightForFooter) {
        heightForFooter = dynamicHeight
    }
    
    public func setFooterHeight(withStaticHeight staticHeight: Double) {
        setFooterHeight { (section, tableView, index) -> Double in
            return staticHeight
        }
    }
    
    public typealias HeightForFooter = (section: Section, tableView: UITableView, index: Int) -> Double
    public typealias ViewForFooter = (section: Section, tableView: UITableView, index: Int) -> UIView
    public typealias TitleForFooter = (section: Section, tableView: UITableView, index: Int) -> String
    
}
