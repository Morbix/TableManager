//
//  MXTableManager.swift
//  CrossFit Affiliates
//
//  Created by Henrique Morbin on 11/10/15.
//  Copyright © 2015 Morbix. All rights reserved.
//

import UIKit

internal let defaultCellIdentifier = "DefaultCellIdentifier"

public class TableManager: NSObject {
    
    /// Reference to the UITableView
    public weak var tableView: UITableView!
    
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
    
    /// Returns the Row by indexPath (only Rows with `visible=true`)
    public func row(atIndexPath indexPath: NSIndexPath) -> Row {
        let section = self.section(atIndex: indexPath.section)
        return section.row(atIndex: indexPath.row)
    }
    
    /// Returns the Section by indexPath (only Section with `visible=true`)
    public func section(atIndex index: Int) -> Section {
        if sectionsToRender.count > index {
            return sectionsToRender[index]
        } else {
            return addSection()
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
        print("move action: " + fromIndexPath.debugDescription + " to " + fromIndexPath.debugDescription)
    }

    public func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        let row = self.row(atIndexPath: indexPath)
        
        return row.deleteConfirmation ?? "Delete"
    }
    
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let section = self.section(atIndex: indexPath.section)
            section.rows.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            print("delete action: " + indexPath.debugDescription)
        }
    }
    
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
