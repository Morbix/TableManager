//
//  MXTableManager.swift
//  CrossFit Affiliates
//
//  Created by Henrique Morbin on 11/10/15.
//  Copyright © 2015 Morbix. All rights reserved.
//

import UIKit

internal let defaultCellIdentifier = "DefaultCellIdentifier"

public protocol TableManagerDelegate: NSObjectProtocol {
    func tableManagerDidMove(fromRow: Row, fromIndexPath: NSIndexPath, toRow: Row, toIndexPath: NSIndexPath)
    func tableManagerDidDelete(row: Row, atIndexPath: NSIndexPath)
}

public class TableManager: NSObject {
    
    /// Reference to the UITableView
    public weak var tableView: UITableView!
    
    /// Reference to the TableManagerDelegate
    public weak var delegate: TableManagerDelegate?
    
    /// The sections added to this table
    public var sections = [Section]()
    
    /// The sections added to this table and with `visible=true`
    public var sectionsToRender: [Section] {
        return sections.filter {
            $0.visible
        }
    }
    
    // A redirection for all the scroll events
    public var scrollViewDelegate: UIScrollViewDelegate?
    
    /// Initializes a new manager with the referenced table
    public required init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
    }
    
    // MARK: Methods
    
    /// Reload the cells
    public func reloadData(){
        tableView.reloadData()
    }
    
    /// Returns the Row by indexPath, includeAll parameter means it will include rows with visible=false too
    public func row(atIndexPath indexPath: NSIndexPath, includeAll: Bool = false) -> Row {
        let section = self.section(atIndex: indexPath.section, includeAll: includeAll)
        return section.row(atIndex: indexPath.row, includeAll: includeAll)
    }
    
    /// Returns the Section by indexPath, includeAll parameter means it will include sections with visible=false too
    public func section(atIndex index: Int, includeAll: Bool = false) -> Section {
        let objects = includeAll ? sections : sectionsToRender
        
        if objects.count > index {
            return objects[index]
        } else {
            return addSection()
        }
    }
    
    /// Returns the indexPath for the row if exist
    public func indexPath(forRow row: Row, includeAll: Bool = false) -> NSIndexPath? {
        let sectionObjects = includeAll ? sections : sectionsToRender
        
        var indexPath: NSIndexPath?
        
        sectionObjects.enumerate().forEach { indexSection, section in
            if let indexRow = section.index(forRow: row, includeAll: includeAll) {
                indexPath = NSIndexPath(forRow: indexRow, inSection: indexSection)
            }
        }
        
        return indexPath
    }
    
    /// Returns the index of the Section if exist
    public func index(forSection section: Section, includeAll: Bool = false) -> Int? {
        let objects = includeAll ? sections : sectionsToRender
        
        return objects.indexOf {
            $0 == section
        }
    }
    
    /// If exist, return the Row that correspond the selected cell
    public func selectedRow() -> Row? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }
        
        return row(atIndexPath: indexPath)
    }
    
    /// If exist, return the Rows that are appearing to the user in the table
    public func visibleRows() -> [Row]? {
        guard let indexPaths = tableView.indexPathsForVisibleRows else {
            return nil
        }
        
        return indexPaths.map {
            row(atIndexPath: $0)
        }
    }
    
    /// Add a new section in the table. If any section is passed as parameter, a new empty section will be allocated, added in the table and returned.
    public func addSection(section: Section? = nil) -> Section {
        let newSection = section ?? Section()
        sections.append(newSection)
        return newSection
    }
    
    /// Add a new row in the table. A new section will be added if don't exist yet. If any row is passed as parameter, a new empty row will be allocated, added in the first section and returned.
    public func addRow(row: Row? = nil) -> Row {
        let firstSection = section(atIndex: 0)
        return firstSection.addRow(row)
    }
    
    /// Initializes a new row with identifier, add it in the table and returns it. A new section will be added if don't exist yet.
    public func addRow(identifier: String) -> Row {
        let firstSection = section(atIndex: 0)
        return firstSection.addRow(identifier)
    }
    
    /// Remove all sections
    public func clearSections() {
        sections.removeAll()
    }
    
    /// Remove all rows from the first section
    public func clearRows() {
        if sections.count > 0 {
            sections[0].clearRows()
        }
    }
}

// MARK: UITableViewDataSource

extension TableManager: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionsToRender.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(atIndex: section).rowsToRender.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = self.row(atIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCellWithIdentifier(row.identifier ?? defaultCellIdentifier, forIndexPath: indexPath)
        
        row.configuration?(row: row, cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection index: Int) -> String? {
        let section = self.section(atIndex: index)
        
        if let titleForHeader = section.titleForHeader {
            return titleForHeader(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, titleForFooterInSection index: Int) -> String? {
        let section = self.section(atIndex: index)
        
        if let titleForFooter = section.titleForFooter {
            return titleForFooter(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let row = self.row(atIndexPath: indexPath)
        
        return row.canMove
    }
    
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let row = self.row(atIndexPath: indexPath)
        
        return row.canEdit
    }
    
    public func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        let row = self.row(atIndexPath: indexPath)
        
        return row.editingStyle
    }
    
    public func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let fromRow = self.row(atIndexPath: fromIndexPath)
        let toRow = self.row(atIndexPath: toIndexPath)
        
        // update the order in tableManager too
        
        // 0 1 2 3 4 5
        // a b c d e f
        // from 4
        // to 2
        //remove 4
        // 0 1 2 3 4
        // a b c d f
        // add in 2
        // 0 1 2 3 4 5
        // a b e c d f
        
        // 0 1 2 3 4 5
        // a b c d e f
        // from 2
        // to 4
        // remove 2
        // 0 1 2 3 4
        // a b d e f
        // add in 4
        // 0 1 2 3 4 5
        // a b d e c f
        
        // 0 1 2 3 4 5
        // a b c d e f
        // from 2
        // to 4
        // add in 4
        // 0 1 2 3 4 5 6
        // a b c d c e f
        // remove 2
        // 0 1 2 3 4 5
        // a b d c e f
        
        //self.sections[]
        
        delegate?.tableManagerDidMove(fromRow, fromIndexPath: fromIndexPath, toRow: toRow, toIndexPath: toIndexPath)
    }

    public func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        let row = self.row(atIndexPath: indexPath)
        
        return row.deleteConfirmation ?? "Delete"
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let section = self.section(atIndex: indexPath.section)
            let row = self.row(atIndexPath: indexPath)
            
            section.rows.removeAtIndex(indexPath.row) // erro aqui, pois aqui considera nao visibles tbm
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            delegate?.tableManagerDidDelete(row, atIndexPath: indexPath)
        }
    }
    
    // done - criar o row at index considerando visible:false
    // criar o indexPath for row
    // criar o indexPath for row considerando visible:false
    // crair converter de indexPath para indexPath considerando visible:false
    
}

// MARK: UITableViewDelegate
    
extension TableManager: UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = self.row(atIndexPath: indexPath)
        row.didSelect?(row: row, tableView: tableView, indexPath: indexPath)
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection index: Int) -> CGFloat {
        let section = self.section(atIndex: index)
        
        if let heightForHeader = section.heightForHeader {
            return CGFloat(heightForHeader(section: section, tableView: tableView, index: index))
        }
        
        return CGFloat(0.0)
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection index: Int) -> UIView? {
        let section = self.section(atIndex: index)
        
        if let viewForHeader = section.viewForHeader {
            return viewForHeader(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection index: Int) -> CGFloat {
        let section = self.section(atIndex: index)
        
        if let heightForFooter = section.heightForFooter {
            return CGFloat(heightForFooter(section: section, tableView: tableView, index: index))
        }
        
        return CGFloat(0.0)
    }
    
    public func tableView(tableView: UITableView, viewForFooterInSection index: Int) -> UIView? {
        let section = self.section(atIndex: index)
        
        if let viewForFooter = section.viewForFooter {
            return viewForFooter(section: section, tableView: tableView, index: index)
        }
        
        return nil
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = self.row(atIndexPath: indexPath)
        
        if let heightForRow = row.heightForRow {
            return CGFloat(heightForRow(row: row, tableView: tableView, index: indexPath.row))
        }
        
        return -1
    }
    
}

extension TableManager: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidZoom(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidZoom?(scrollView)
    }
    
    public func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    public func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollViewDelegate?.viewForZoomingInScrollView?(scrollView)
    }
    
    public func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        scrollViewDelegate?.scrollViewWillBeginZooming?(scrollView, withView: view)
    }
    
    public func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        scrollViewDelegate?.scrollViewDidEndZooming?(scrollView, withView: view, atScale: scale)
    }
    
    public func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        return scrollViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }
    
    public func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    
}

public extension TableManagerDelegate {
    
    public func tableManagerDidMove(fromRow: Row, fromIndexPath: NSIndexPath, toRow: Row, toIndexPath: NSIndexPath) {
        // empty implementation to transform the delegate optional
    }
    
    public func tableManagerDidDelete(row: Row, atIndexPath: NSIndexPath) {
        // empty implementation to transform the delegate optional
    }
    
}
