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

You can also install it manually just draging [TableManager](https://github.com/Morbix/TableManager/blob/master/TableManager.swift) file to your project. 


## Required Configuration

After your `UITableView` `IBOutlet` declaration, declare a lazy var of `TableManager` passing your table as parameter.
```swift
@IBOutlet var table: UITableView!
lazy var tableManager : TableManager = TableManager(tableView: self.table)
```

## Usage - TO DO

### Basic Usage
Create a UITableViewController and follow this steps for a basic configuration
```swift
class TableViewController: UITableViewController {

    //1 - Declaring a var of TableManager passing the UITableView instance (Required Configuration)
    lazy var tableManager : TableManager = TableManager(tableView: self.tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2 - Setting the default state cells (states: Loading / Empty / Error)
        tableManager.stateRows = TableManager.getDefaultStateRows()
        
        //3 - Setting the Loading state
        tableManager.state = .Loading
        
        //4 - Simulating a delay to be able to see the Loading State Cell
        performSelector(Selector("loadFakeData"), withObject: nil, afterDelay: 3)
    }

    func loadFakeData(){
        let identifier = "<#Put here a valid UITableViewCell identifier#>"
        let fakeData = ["A", "B", "C", "D", "E"]
        
        //5 - Adding a empty section
        tableManager.sections.append(Section())
        
        
        for letter in fakeData {
            
            //6 - Declaring a instance of Row
            let row = Row(identifier: identifier, object: letter) { (object, cell, indexPath) -> Void in
                if let object = object as? String {
                    cell.textLabel?.text = object
                }
            }
            
            //7 - Adding our Row to our Section
            tableManager.sections[0].rows.append(row)
        }
        
        //7 - Setting the None state
        tableManager.state = .None 
    }
}
```
The `.None` state tells to TableManager to hide any kind of Loading/Empty/Error Cells and show the configured sections and rows that we added before.
Other thing, every time you change the tableManager.state, the reloadData will be called automatically.

## Contribute

Feel free to submit your pull request, suggest any update, report a bug or create a feature request. 

Just want to say `hello`? -> morbin_ at hotmail.com

## Contributors

Author: [@Morbin_](https://twitter.com/Morbin_) 

See the people who helps to improve this project: [Contributors](https://github.com/Morbix/TableManager/graphs/contributors) ♥


## License

TableManager is available under the MIT license. See the LICENSE file for more info.
