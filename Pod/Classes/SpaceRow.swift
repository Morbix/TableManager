//
//  SpaceRow.swift
//  Pods
//
//  Created by Henrique Morbin on 21/12/16.
//
//

import Foundation

open class SpaceRow: Row {
    
    public required init(height: Double = 8.0, bgColor: UIColor = .clear, selectionStyle: UITableViewCellSelectionStyle = .none) {
        super.init(identifier: nil, visible: true, object: nil)
        
        self.setHeight(withStaticHeight: height)
        
        self.setConfiguration { _, cell, _ in
            cell.backgroundColor = bgColor
            cell.selectionStyle = selectionStyle
        }
    }
    
    public required init(identifier: String?, visible: Bool, object: AnyObject?) {
        super.init(identifier: identifier, visible: visible, object: object)
    }
    
}

extension UITableView {
    @discardableResult
    public func addSpace(height: Double = 8.0, bgColor: UIColor = .clear) -> Row {
        return addRow(SpaceRow(height: height, bgColor: bgColor))
    }
}

extension Section {
    @discardableResult
    public func addSpace(height: Double = 8.0, bgColor: UIColor = .clear) -> Row {
        return addRow(SpaceRow(height: height, bgColor: bgColor))
    }
}
