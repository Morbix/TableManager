//
//  MXTableManager.swift
//  CrossFit Affiliates
//
//  Created by Henrique Morbin on 11/10/15.
//  Copyright © 2015 Morbix. All rights reserved.
//

import UIKit

internal let defaultCellIdentifier = "DefaultCellIdentifier"
internal let defaultCellHeight = 44.0

public protocol TableManagerDelegate: NSObjectProtocol {
    func tableManagerDidMove(_ fromRow: Row, fromIndexPath: IndexPath, toRow: Row, toIndexPath: IndexPath)
    func tableManagerDidDelete(_ row: Row, atIndexPath: IndexPath)
}

open class TableManager: NSObject {
    
    /// Reference to the UITableView
    open weak var tableView: UITableView!
    
    /// Reference to the TableManagerDelegate
    open weak var delegate: TableManagerDelegate?
    
    /// The sections added to this table
    open var sections = [Section]()
    
    /// The sections added to this table and with `visible=true`
    open var sectionsToRender: [Section] {
        return sections.filter {
            $0.visible
        }
    }
    
    // A redirection for all the scroll events
    open weak var scrollViewDelegate: UIScrollViewDelegate?
    
    /// Initializes a new manager with the referenced table
    public required init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
    }
    
    // MARK: Methods
    
    /// Reload the cells
    open func reloadData() {
        tableView.reloadData()
    }
    
    /// Returns the Row by indexPath, includeAll parameter means it will include rows with visible=false too
    open func row(atIndexPath indexPath: IndexPath, includeAll: Bool = false) -> Row {
        let section = self.section(atIndex: indexPath.section, includeAll: includeAll)
        return section.row(atIndex: indexPath.row, includeAll: includeAll)
    }
    
    /// Returns the Section by indexPath, includeAll parameter means it will include sections with visible=false too
    open func section(atIndex index: Int, includeAll: Bool = false) -> Section {
        let objects = includeAll ? sections : sectionsToRender
        
        if objects.count > index {
            return objects[index]
        } else {
            return Section()
        }
    }
    
    /// Returns the indexPath for the row if exist
    open func indexPath(forRow row: Row, includeAll: Bool = false) -> IndexPath? {
        let sectionObjects = includeAll ? sections : sectionsToRender
        
        var indexPath: IndexPath?
        
        sectionObjects.enumerated().forEach { indexSection, section in
            if let indexRow = section.index(forRow: row, includeAll: includeAll) {
                indexPath = IndexPath(row: indexRow, section: indexSection)
            }
        }
        
        return indexPath
    }
    
    /// Returns the index of the Section if exist
    open func index(forSection section: Section, includeAll: Bool = false) -> Int? {
        let objects = includeAll ? sections : sectionsToRender
        
        return objects.index {
            $0 == section
        }
    }
    
    /// If exist, return the Row that correspond the selected cell
    open func selectedRow() -> Row? {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return nil
        }
        
        return row(atIndexPath: indexPath)
    }
    
    /// If exist, return the Rows that are appearing to the user in the table
    open func visibleRows() -> [Row]? {
        guard let indexPaths = tableView.indexPathsForVisibleRows else {
            return nil
        }
        
        return indexPaths.map {
            row(atIndexPath: $0)
        }
    }
    
    /// Add a new section in the table. If any section is passed as parameter, a new empty section will be allocated, added in the table and returned.
    @discardableResult
    open func addSection(_ section: Section? = nil) -> Section {
        let newSection = section ?? Section()
        if index(forSection: newSection, includeAll: true) == nil {
            sections.append(newSection)
        }
        return newSection
    }
    
    /// Add a new row in the table. A new section will be added if don't exist yet. If any row is passed as parameter, a new empty row will be allocated, added in the first section and returned.
    @discardableResult
    open func addRow(_ row: Row? = nil) -> Row {
        let firstSection: Section
        if sections.count > 0 {
            firstSection = section(atIndex: 0)
        } else {
            firstSection = addSection()
        }
        
        return firstSection.addRow(row)
    }
    
    /// Initializes a new row with identifier, add it in the table and returns it. A new section will be added if don't exist yet.
    @discardableResult
    open func addRow(_ identifier: String) -> Row {
        return addRow(Row(identifier: identifier))
    }
    
    /// Remove all sections
    open func clearSections() {
        sections.removeAll()
    }
    
    /// Remove all rows from the first section
    open func clearRows() {
        if sections.count > 0 {
            sections[0].clearRows()
        }
    }
    
    /// Convert an indexPath for row with visible: true to an indexPath including all rows
    func convertToIncludeAllIndexPath(withToRenderIndexPath indexPath: IndexPath) -> IndexPath? {
        let row = self.row(atIndexPath: indexPath)
        return self.indexPath(forRow: row, includeAll: true)
    }
}

// MARK: - UITableViewDataSource

extension TableManager: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsToRender.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section(atIndex: section).rowsToRender.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.row(atIndexPath: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.identifier ?? defaultCellIdentifier, for: indexPath)
        
        row.cell = cell
        row.configuration?(row, cell, indexPath)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection index: Int) -> String? {
        let section = self.section(atIndex: index)
        
        if let titleForHeader = section.titleForHeader {
            return titleForHeader(section, tableView, index)
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection index: Int) -> String? {
        let section = self.section(atIndex: index)
        
        if let titleForFooter = section.titleForFooter {
            return titleForFooter(section, tableView, index)
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let row = self.row(atIndexPath: indexPath)
        return row.canMove
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let row = self.row(atIndexPath: indexPath)
        return row.canEdit
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        let row = self.row(atIndexPath: indexPath)
        return row.editingStyle
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow = self.row(atIndexPath: fromIndexPath)
        let toRow = self.row(atIndexPath: toIndexPath)
        
        if let fromIndexPathIncludeAll = convertToIncludeAllIndexPath(withToRenderIndexPath: fromIndexPath) {
            sections[fromIndexPathIncludeAll.section].rows.remove(at: fromIndexPathIncludeAll.row)
            if let toIndexPathIncludeAll = convertToIncludeAllIndexPath(withToRenderIndexPath: toIndexPath) {
                sections[toIndexPathIncludeAll.section].rows.insert(fromRow, at: toIndexPathIncludeAll.row)
                delegate?.tableManagerDidMove(fromRow, fromIndexPath: fromIndexPath, toRow: toRow, toIndexPath: toIndexPath)
            }
        }
    }

    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let row = self.row(atIndexPath: indexPath)
        return row.deleteConfirmation ?? "Delete"
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let row = self.row(atIndexPath: indexPath)
            
            if let includeAllIndexPath = convertToIncludeAllIndexPath(withToRenderIndexPath: indexPath) {
                sections[includeAllIndexPath.section].rows.remove(at: includeAllIndexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                delegate?.tableManagerDidDelete(row, atIndexPath: indexPath)
            }
        }
    }

    public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let row = self.row(atIndexPath: indexPath)
        return row.actions
    }
    
}

// MARK: - UITableViewDelegate
    
extension TableManager: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = self.row(atIndexPath: indexPath)
        row.willDisplay?(row, tableView, cell, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.row(atIndexPath: indexPath)
        row.didSelect?(row, tableView, indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection index: Int) -> CGFloat {
        let section = self.section(atIndex: index)
        
        if let heightForHeader = section.heightForHeader {
            return CGFloat(heightForHeader(section, tableView, index))
        }
        
        return CGFloat(0.0)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection index: Int) -> UIView? {
        let section = self.section(atIndex: index)
        
        if let viewForHeader = section.viewForHeader {
            return viewForHeader(section, tableView, index)
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection index: Int) -> CGFloat {
        let section = self.section(atIndex: index)
        
        if let heightForFooter = section.heightForFooter {
            return CGFloat(heightForFooter(section, tableView, index))
        }
        
        return CGFloat(0.0)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection index: Int) -> UIView? {
        let section = self.section(atIndex: index)
        
        if let viewForFooter = section.viewForFooter {
            return viewForFooter(section, tableView, index)
        }
        
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.row(atIndexPath: indexPath)
        
        row.tableViewReference = tableView
        row.indexPathReference = indexPath
        
        if let heightForRow = row.heightForRow {
            return CGFloat(heightForRow(row, tableView, indexPath))
        }
        
        return CGFloat(defaultCellHeight)
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.compactMap { $0.indexTitle }
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let section = (sections.filter { $0.indexTitle == title }.first) else {
            return 0
        }
        
        guard let indexOfSection = sections.index(of: section) else {
            return 0
        }
        
        return indexOfSection
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = self.row(atIndexPath: indexPath)
        row.cell = nil
    }
}

// MARK: - UIScrollViewDelegate

extension TableManager: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidZoom?(scrollView)
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDragging?(scrollView)
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollViewDelegate?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollViewDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewWillBeginDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollViewDelegate?.viewForZooming?(in: scrollView)
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollViewDelegate?.scrollViewWillBeginZooming?(scrollView, with: view)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollViewDelegate?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
    }
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return scrollViewDelegate?.scrollViewShouldScrollToTop?(scrollView) ?? true
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        scrollViewDelegate?.scrollViewDidScrollToTop?(scrollView)
    }
    
}

// MARK: - TableManagerDelegate

public extension TableManagerDelegate {
    
    public func tableManagerDidMove(_ fromRow: Row, fromIndexPath: IndexPath, toRow: Row, toIndexPath: IndexPath) {
        // empty implementation to transform the delegate optional
    }
    
    public func tableManagerDidDelete(_ row: Row, atIndexPath: IndexPath) {
        // empty implementation to transform the delegate optional
    }
    
}
