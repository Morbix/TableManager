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

### Basic Usage - 5 Steps Only
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

### Configuring Row or Custom Row
You can implement the `ConfigureCellBlock` directly in the Row constructor:
```swift
let row = Row(identifier: "SomeIdentifier", object: someObject) { (object, cell, indexPath) -> Void in
    if let object = object as? String {
        cell.textLabel?.text = object
    }
}
```

Or declare some `ConfigureCellBlock` and attribute it to a group of Rows:
```swift
let block:ConfigureCellBlock = { (object, cell, indexPath) -> Void in
    if let object = object as? String {
        cell.textLabel?.text = object
    }
}
let rowA = Row(identifier: "SomeIdentifier", object: someObject, configureCell: block)
let rowB = Row(identifier: "SomeIdentifier", object: otherObject, configureCell: block)
```

Or implement the full `CellForRowAtIndexPathBlock` as you already know:
```swift
let row = Row(identifier: "SomeIdentifier", object: someObject, configureCell: nil)
row.cellForRowAtIndexPath = { (row: Row, tableView: UITableView,  indexPath: NSIndexPath) -> UITableViewCell in

    let cell = tableView.dequeueReusableCellWithIdentifier(row.identifier, forIndexPath: indexPath)

    if let object = row.object as? String {
        cell.textLabel?.text = object
    }

    return cell
}
```

Don't forget to `reloadData` to update cells
```swift
tableManager.reloadData()
```

### Row Selection
You can implement the `didSelectRowAtIndexPath` directly in the row:
```swift
let row = Row(identifier: "SomeIdentifier", object: someObject, configureCell: nil)
row.didSelectRowAtIndexPath = { (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void in
    print("someObject selected")
}
```

Or declare some `DidSelectRowAtIndexPath` and attribute it to a group of Rows:
```swift
let block:DidSelectRowAtIndexPath = { (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void in
	if let object = row.object {
    	print((object as! String) + " selected")
    }
}

let rowA = Row(identifier: "SomeIdentifier", object: someObject, configureCell: nil)
let rowB = Row(identifier: "SomeIdentifier", object: otherObject, configureCell: nil)
let rowC = Row(identifier: "SomeIdentifier", object: anotherObject, configureCell: nil)

rowA.didSelectRowAtIndexPath = block
rowB.didSelectRowAtIndexPath = block
rowC.didSelectRowAtIndexPath = block
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
