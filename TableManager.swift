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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(row.identifier, forIndexPath: indexPath)
        
        row.configuration?(row: row, cell: cell, indexPath: indexPath)
        
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
        
        if let titleForHeader = section.titleForHeader {
            return titleForHeader(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection index: Int) -> UIView? {
        let section = sectionForIndex(index)
        
        if let viewForHeader = section.viewForHeader {
            return viewForHeader(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
}

// MARK: UITableViewDelegate
    
extension TableManager: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = rowForIndexPath(indexPath)
        row.didSelect?(row: row, tableView: tableView, indexPath: indexPath)
    }
    
}


// MARK: Section Class

public class Section {
    
    public var visible = true
    public var rows = [Row]()
    public var visibleRows: [Row] {
        return rows.filter {
            $0.visible
        }
    }
    
    public var heightForStaticHeader = 0.0
    public var heightForHeaderInSection: HeightForHeaderInSectionBlock?
    public var titleForHeader: TitleForHeaderBlock?
    public var viewForHeader: ViewForHeaderBlock?
    
    public func rowForIndex(index: Int) -> Row {
        if visibleRows.count > index {
            return visibleRows[index]
        } else {
            let row = Row(withIdentifier: defaultIdentifier)
            rows.append(row)
            return row
        }
    }
    
    func setTitleForHeader(block: TitleForHeaderBlock) {
        self.titleForHeader = block
    }
    
    func setTitleForHeader(text: String) {
        self.setTitleForHeader { (section, tableView, index) -> String in
            return text
        }
    }
    
    func setViewForHeader(block: ViewForHeaderBlock) {
        self.viewForHeader = block
    }
    
    func setViewForHeader(view: UIView) {
        self.setViewForHeader { (section, tableView, index) -> UIView in
            return view
        }
    }
    
    public typealias HeightForHeaderInSectionBlock = (section: Section, tableView: UITableView, index: Int) -> CGFloat
    public typealias ViewForHeaderBlock = (section: Section, tableView: UITableView, index: Int) -> UIView
    public typealias TitleForHeaderBlock = (section: Section, tableView: UITableView, index: Int) -> String
    
}

// MARK: Row Class

public class Row {
    
    public let identifier: String
    public var visible = true
    
    public var object: AnyObject?
    public var configuration: ConfigurationBlock?
    public var didSelect: DidSelectBlock?
    
    public init(withIdentifier identifier: String){
        self.identifier = identifier
    }
    
    func setObject(object: AnyObject) {
        self.object = object
    }
    
    func setConfiguration(block: ConfigurationBlock) {
        self.configuration = block
    }
    
    func setDidSelect(block: DidSelectBlock) {
        self.didSelect = block
    }
    
    public typealias ConfigurationBlock = (row: Row, cell: UITableViewCell, indexPath: NSIndexPath) -> Void
    public typealias DidSelectBlock = (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void
}
