# TableManager

[![Version](https://img.shields.io/cocoapods/v/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)
[![License](https://img.shields.io/cocoapods/l/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)
[![Platform](https://img.shields.io/cocoapods/p/TableManager.svg?style=flat)](http://cocoapods.org/pods/TableManager)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


`TableManager` is a wrapper and it was created to use and manipulate the UITableView easier. You can add Row and Section's objects then the manager will handle all the protocol implementation for you.

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


## Basic Usage

### Configure a table with only 3 tiny steps
```swift
import TableManager // 1 - import TableManager

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let data = (1...1_000).map { "Row \($0)" }

        data.forEach { element in
            let row = tableView.addRow() // 2 - Add a row

            row.setConfiguration { (row, cell, indexPath) in // 3 - And configure it
                cell.textLabel?.text = element
            }
        }

        tableView.reloadData()
    }

}
```
#### Result
![Basic Usage](basic-usage.png)

## Documentation

### Sections & Rows Visibility

You can change the property `visible` from any Section and any Row. In the example below the only elements that will appear in the table will be the `sectionA` and `rowB`.
```swift
let sectionA = tableView.addSection()
sectionA.visible = true

let rowA = tableView.addRow()
rowA.visible = false

let rowB = tableView.addRow()
rowB.visible = true
```


### Configuring a custom Row
You can set a identifier and the `configuration` property:
```swift
let row = Row(identifier: "CellBasic", object: someString)

row.setConfiguration { (row, cell, indexPath) in
    if let text = row.object as? String {
        cell.textLabel?.text = text
    }
}

tableView.addRow(row)
```

Or declare a `Row.Configuration` and attribute it to any row:
```swift
let configuration: Row.Configuration = { (row, cell, indexPath) -> Void in
    if let text = object as? String {
        cell.textLabel?.text = text
    }
}
let rowA = tableView.addRow(Row(identifier: "CellBasic", object: someObject))
rowA.setConfiguration(configuration)

let rowB = tableView.addRow(Row(identifier: "CellBasic", object: otherObject))
rowB.setConfiguration(configuration)
```


### Row Selection
You can set the `didSelect` property:
```swift
let row = Row(object: someString)

row.setDidSelect { (row, tableView, indexPath) in
    if let text = row.object as? String {
        print(text + " selected")
    }
}

tableView.addRow(row)
```

Or declare a `Row.DidSelect` and attribute it to any row:
```swift
let didSelect: Row.DidSelect = { (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void in
    if let text = row.object as? String {
        print(text + " selected")
    }
}

let rowA = tableView.addRow(Row(object: someString))
rowA.setDidSelect(didSelect)

let rowB = tableView.addRow(Row(object: someString))
rowB.setDidSelect(didSelect)
```


## Release Notes

* 1.3.0
    * ADD: Support to manipulate row's height;
    * ADD: Method `addSection` to add a section without having to use `sections.append`;
    * ADD: Method `addRow` to add a row without having to use `rows.append`;
    * ADD: Method `addRow` to add a row directly from the table without having to set a section;
* 1.2.0
    * CHANGE: Refactor the `visibleSections`/`visibleRows` to `sectionsToRender`/`rowsToRender`;
    * CHANGE: Refactor the `displayedRows` to `visibleRows` to be consistent with Apple's framework (visible rows now means the rows that are appearing to the user in the table);
    * ADD: A UITableView extension to use all TableManager features directly in the tableView instance;
    * ADD: A `UIScrollViewDelegate` property to redirect all the scroll events.
* 1.1.0
    * ADD: `selectedRow()` method in TableManger class;
    * ADD: `displayedRows()` method in TableManger class; (suggestion by @lfarah)
* 1.0.0
    * First official release;
    * FIX: Swift style code;
    * ADD: Support to Footer configuration;
    * ADD: Section constructor;
    * CHANGE: All API;
    * CHANGE: Remove `stateRows` property;
    * CHANGE: Remove `StateRowsTuple` typealias;
    * CHANGE: Remove `ScreenState` enum;
    * CHANGE: Remove `ConfigureCell` protocol;
* 0.0.3
    * Some fixes;
    * ADD: Example project;
    * FIX: A bug was blocking the usage as pod;
    * FIX: Rename `setByResulsAndErrors()` to `setByResultsAndErrors()`
* 0.0.1
    * Creating pod

## Contribute

Feel free to submit your pull request, suggest any update, report a bug or create a feature request.

Just want to say hello? -> [morbin_@hotmail.com](mailto://morbin_@hotmail.com)

## Contributors

Author: [@Morbin_](https://twitter.com/Morbin_) / [fb.com/hgmorbin](https://www.facebook.com/hgmorbin)

See the people who helps to improve this project: [Contributors](https://github.com/Morbix/TableManager/graphs/contributors) ♥


## License

TableManager is available under the MIT license. See the LICENSE file for more info.
