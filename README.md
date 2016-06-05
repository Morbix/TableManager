# TableManager

[![Version](https://img.shields.io/cocoapods/v/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)
[![License](https://img.shields.io/cocoapods/l/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)
[![Platform](https://img.shields.io/cocoapods/p/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)

`TableManager` is a wrapper to easily manipulate the UITableView: Rows, Sections, Rows and Sections Visibilities, Static Contents and more.

## Requirements

It requires Xcode 7.0+ and Swift 2.0.

Your project deployment target must be `iOS 8.0+`

## Installation

### CocoaPods

TableManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TableManager'
```

### Manually

You can also install it manually just dragging [TableManager](https://github.com/Morbix/TableManager/blob/master/TableManager.swift) file to your project.


## Required Configuration

In your View Controller declare a lazy var of `TableManager` passing your tableView as parameter.
```swift
lazy var tableManager: TableManager = TableManager(tableView: self.tableView)
```

## Usage

### Basic Usage - Configure a table with only 5 tiny steps
```swift
class TableViewController: UITableViewController {

    // 1 - Declare a var of TableManager passing the UITableView instance
    lazy var tableManager: TableManager = TableManager(tableView: self.tableView)

    override func viewDidLoad() {
        super.viewDidLoad()

        // 2 - Declare a section and add it in the tableManager
        let section = Section()
        tableManager.sections.append(section)

        let data = ["Basic Usage", "Row Selection", "Sections & Rows Visibility", "Custom Cells"]

        data.forEach {
            // 3 - Declare a Row and configure it
            let row = Row(withIdentifier: "CellBasic", object: $0)

            row.setConfiguration { (row, cell, indexPath) in
                if let text = row.object as? String {
                    cell.textLabel?.text = text
                }
            }

            row.setDidSelect { (row, tableView, indexPath) in
                if let text = row.object as? String {
                    print(text + " selected")
                }
            }

            // 4 - Add the Row in the section
            section.rows.append(row)
        }

        // 5 - Reload data
        tableManager.reloadData()
    }
}
```


### Sections & Rows Visibility

You can change the property `visible` from any Section and any Row. In the example below the only elements that will appear in the table will be the `sectionA` and `rowB`.
```swift
let sectionA = Section()
sectionA.visible = true

let rowA = Section()
rowA.visible = false

let rowB = Section()
rowB.visible = true
```

Don't forget to `reloadData` to update cells
```swift
tableManager.reloadData()
```

### Configuring a Row
You can set the `configuration` property:
```swift
let row = Row(withIdentifier: "CellBasic", object: someString)

row.setConfiguration { (row, cell, indexPath) in
    if let text = row.object as? String {
        cell.textLabel?.text = text
    }
}
```

Or declare a `Row.Configuration` and attribute it to any row:
```swift
let configuration: Row.Configuration = { (row, cell, indexPath) -> Void in
    if let text = object as? String {
        cell.textLabel?.text = text
    }
}
let rowA = Row(withIdentifier: "CellBasic", object: someObject)
rowA.setConfiguration(configuration)

let rowB = Row(withIdentifier: "CellBasic", object: otherObject)
rowB.setConfiguration(configuration)
```

Don't forget to `reloadData` to update cells
```swift
tableManager.reloadData()
```

### Row Selection
You can set the `didSelect` property:
```swift
let row = Row(withIdentifier: "CellBasic", object: someString)

row.setDidSelect { (row, tableView, indexPath) in
    if let text = row.object as? String {
        print(text + " selected")
    }
}
```

Or declare a `Row.DidSelect` and attribute it to any row:
```swift
let didSelect: Row.DidSelect = { (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void in
    if let text = row.object as? String {
        print(text + " selected")
    }
}

let rowA = Row(withIdentifier: "CellBasic", object: someString)
rowA.setDidSelect(didSelect)

let rowB = Row(withIdentifier: "CellBasic", object: someString)
rowB.setDidSelect(didSelect)
```

Don't forget to `reloadData` to update cells
```swift
tableManager.reloadData()
```

## Library Progress

### Released
- Section & Row's Visibility
- Header For Section (with static and dynamic values)
- Footer For Section (with static and dynamic values)
- Row's Configuration
- Row's Selection


### To be implemented
- canEditRowAtIndexPath (UITableViewDataSource)
- canMoveRowAtIndexPath (UITableViewDataSource)
- sectionIndexTitlesForTableView (UITableViewDataSource)
- sectionForSectionIndexTitle (UITableViewDataSource)
- commitEditingStyle (UITableViewDataSource)
- moveRowAtIndexPath (UITableViewDataSource)
- willDisplayCell (UITableViewDelegate)
- willDisplayHeaderView (UITableViewDelegate)
- willDisplayFooterView (UITableViewDelegate)
- didEndDisplayingCell (UITableViewDelegate)
- didEndDisplayingHeaderView (UITableViewDelegate)
- didEndDisplayingFooterView (UITableViewDelegate)
- **heightForRowAtIndexPath (UITableViewDelegate)**
- estimatedHeightForRowAtIndexPath (UITableViewDelegate)
- estimatedHeightForHeaderInSection (UITableViewDelegate)
- estimatedHeightForFooterInSection (UITableViewDelegate)
- accessoryButtonTappedForRowWithIndexPath (UITableViewDelegate)
- shouldHighlightRowAtIndexPath (UITableViewDelegate)
- didHighlightRowAtIndexPath (UITableViewDelegate)
- didUnhighlightRowAtIndexPath (UITableViewDelegate)
- willSelectRowAtIndexPath (UITableViewDelegate)
- willDeselectRowAtIndexPath (UITableViewDelegate)
- didDeselectRowAtIndexPath (UITableViewDelegate)
- editingStyleForRowAtIndexPath (UITableViewDelegate)
- titleForDeleteConfirmationButtonForRowAtIndexPath (UITableViewDelegate)
- editActionsForRowAtIndexPath (UITableViewDelegate)
- shouldIndentWhileEditingRowAtIndexPath (UITableViewDelegate)
- willBeginEditingRowAtIndexPath (UITableViewDelegate)
- didEndEditingRowAtIndexPath (UITableViewDelegate)
- targetIndexPathForMoveFromRowAtIndexPath (UITableViewDelegate)
- indentationLevelForRowAtIndexPath (UITableViewDelegate)
- shouldShowMenuForRowAtIndexPath (UITableViewDelegate)
- canPerformAction (UITableViewDelegate)
- performAction (UITableViewDelegate)
- canFocusRowAtIndexPath (UITableViewDelegate)
- shouldUpdateFocusInContext (UITableViewDelegate)
- didUpdateFocusInContext (UITableViewDelegate)
- indexPathForPreferredFocusedViewInTableView (UITableViewDelegate)


## Contribute

Feel free to submit your pull request, suggest any update, report a bug or create a feature request.

Just want to say hello? -> [morbin_@hotmail.com](mailto://morbin_@hotmail.com)

## Contributors

Author: [@Morbin_](https://twitter.com/Morbin_) / [fb.com/hgmorbin](https://www.facebook.com/hgmorbin)

See the people who helps to improve this project: [Contributors](https://github.com/Morbix/TableManager/graphs/contributors) ♥


## License

TableManager is available under the MIT license. See the LICENSE file for more info.
