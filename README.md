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

## Usage - TO DO

### ***Required Configuration***

After your `UITableView` `IBOutlet` declaration, declare a lazy var of `TableManager` passing your table as parameter.
```swift
@IBOutlet var table: UITableView!
lazy var tableManager : TableManager = TableManager(tableView: self.table)
```


## Who's Using It? 

TO DO 

## Contribute

Feel free to submit your pull request, suggest any update, report a bug or create a feature request. 

Just want to say `hello`? -> morbin_ at hotmail.com

## Contributors

Author: [@Morbin_](https://twitter.com/Morbin_) 

See the people who helps to improve this project: [Contributors](https://github.com/Morbix/TableManager/graphs/contributors) ♥


## License

TableManager is available under the MIT license. See the LICENSE file for more info.
