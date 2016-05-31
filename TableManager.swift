//
//  MXTableManager.swift
//  CrossFit Affiliates
//
//  Created by Henrique Morbin on 11/10/15.
//  Copyright © 2015 Morbix. All rights reserved.
//

import UIKit

private let defaultIdentifier = "TableManager_Default_Cell"

public class TableManager: NSObject {
    
    public weak var tableView: UITableView!
    
    public var sections = [Section]()
    public var visibleSections: [Section] {
        return sections.filter {
            $0.visible
        }
    }
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultIdentifier)
    }
    
    // MARK: Methods
    
    public func reloadData(){
        tableView.reloadData()
    }
    
    public func rowForIndexPath(indexPath: NSIndexPath) -> Row {
        let section = sectionForIndex(indexPath.section)
        return section.rowForIndex(indexPath.row)
    }
    
    public func sectionForIndex(index: Int) -> Section {
        if visibleSections.count > index {
            return visibleSections[index]
        } else {
            let section = Section()
            sections.append(section)
            return section
        }
    }
    
}

// MARK: UITableViewDataSource

extension TableManager: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return visibleSections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionForIndex(section).visibleRows.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = rowForIndexPath(indexPath)

        if let cellForRowAtIndexPath = row.cellForRowAtIndexPath {
            return cellForRowAtIndexPath(row: row, tableView: tableView, indexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(row.identifier, forIndexPath: indexPath)
        
        if let configureCell = row.configureCell {
            configureCell(object: row.object, cell: cell, indexPath: indexPath)
        }
        
        return cell
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection index: Int) -> CGFloat {
        
        let section = sectionForIndex(index)
        
        if let heightForHeaderInSection = section.heightForHeaderInSection {
            return heightForHeaderInSection(section: section, tableView: tableView, index: index)
        }
        
        return CGFloat(section.heightForStaticHeader)
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection index: Int) -> String? {
        let section = sectionForIndex(index)
        
        if let titleForHeaderInSection = section.titleForHeaderInSection {
            return titleForHeaderInSection(section: section, tableView: tableView, index: index)
        }
        
        if let titleForStaticHeader = section.titleForStaticHeader {
            return titleForStaticHeader
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection index: Int) -> UIView? {
        let section = sectionForIndex(index)
        
        if let viewForHeaderInSection = section.viewForHeaderInSection {
            return viewForHeaderInSection(section: section, tableView: tableView, index: index)
        }
        
        if let viewForStaticHeader = section.viewForStaticHeader {
            return viewForStaticHeader
        }
        
        return nil
    }
}

// MARK: UITableViewDelegate
    
extension TableManager: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = rowForIndexPath(indexPath)
        
        if let didSelectRowAtIndexPath = row.didSelectRowAtIndexPath {
            didSelectRowAtIndexPath(row: row, tableView: tableView, indexPath: indexPath)
        }
    }
    
}


// MARK: Classes

public class Section: NSObject {
    
    public var visible = true
    public var rows = [Row]()
    public var visibleRows: [Row] {
        return rows.filter {
            $0.visible
        }
    }
    public var heightForStaticHeader = 0.0
    public var heightForHeaderInSection: HeightForHeaderInSectionBlock?
    public var titleForStaticHeader: String?
    public var titleForHeaderInSection: TitleForHeaderInSectionBlock?
    public var viewForStaticHeader: UIView?
    public var viewForHeaderInSection: ViewForHeaderInSectionBlock?
    
    public func rowForIndex(index: Int) -> Row {
        if visibleRows.count > index {
            return visibleRows[index]
        } else {
            let row = Row(identifier: defaultIdentifier, object: nil, configureCell: nil)
            rows.append(row)
            return row
        }
    }
    
}

public class Row: NSObject {
    
    public let identifier: String
    public var visible = true
    public var object: AnyObject?
    public var configureCell: (ConfigureCellBlock)?
    public var cellForRowAtIndexPath: (CellForRowAtIndexPathBlock)?
    public var didSelectRowAtIndexPath: (DidSelectRowAtIndexPath)?
    
    public init(identifier: String){
        self.identifier = identifier
    }

    public convenience init(identifier:String, object:AnyObject?, configureCell:ConfigureCellBlock?) {
        self.init(identifier: identifier)
        
        self.object = object
        self.configureCell = configureCell
    }
    
}

// MARK: Type Alias

public typealias StateRowsTuple = (loading: Row, empty: Row, error: Row)
public typealias ConfigureCellBlock = (object:Any?, cell:UITableViewCell, indexPath: NSIndexPath) -> Void
public typealias CellForRowAtIndexPathBlock = (row: Row, tableView: UITableView,  indexPath: NSIndexPath) -> UITableViewCell
public typealias HeightForHeaderInSectionBlock = (section: Section, tableView: UITableView, index: Int) -> CGFloat
public typealias ViewForHeaderInSectionBlock = (section: Section, tableView: UITableView, index: Int) -> UIView
public typealias TitleForHeaderInSectionBlock = (section: Section, tableView: UITableView, index: Int) -> String
public typealias DidSelectRowAtIndexPath = (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void
