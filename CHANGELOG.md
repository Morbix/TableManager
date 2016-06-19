# TableManager CHANGELOG

## 1.4.0
### New Features
* Support to Drag & Drop feature
* Support to Deletion feature
* **TableManager**
  * Added `index(forSection section: Section, includeAll: Bool = false) -> Int?` to get the index of a Section
  * Added `indexPath(forRow row: Row, includeAll: Bool = false) -> NSIndexPath?` to get the indexPath of a Row
* **Section**
  * Added `index(forRow row: Row, includeAll: Bool = false) -> Int?` to get the index of a Row
* **Row**
  * Added `setCanMove(movable: Bool)` to make the row draggable
  * Added `setCanDelete(deletable: Bool, titleForDeleteConfirmation: String? = nil)` to make the row deletable

### Changes
* **TableManager**
  * Added a optional parameter in `section(atIndex index: Int, includeAll: Bool = false) -> Section` to include even sections with visible:false
  * Added a optional parameter in `row(atIndexPath indexPath: NSIndexPath, includeAll: Bool = false) -> Row` to include even rows with visible:false
* **Section**
  * Added a optional parameter in `ow(atIndex index: Int, includeAll: Bool = false) -> Row` to include even rows with visible:false 

## 1.3.1
### New Features
* **TableManager**
  * Added a method `clearSections` to remove all section from the table;
  * Added a method `clearRows` to remove all rows from the first section;
* **Section**
  * Added a method `clearRows` to remove all rows from the section;

## 1.3.0
### New Features
* **TableManager**
  * Added a method `addSection` in class `TableManager` to add a section without having to use `sections.append`;
  * Added a method `addRow` in class `TableManager` to add a row directly from the table without having to set a section;
* **Section**
  * Added a method `addRow` in class `Section` to add a row without having to use `rows.append`;
* **Row**
  * Added support to manipulate row's height;
  
## 1.2.0
    * CHANGE: Refactor the `visibleSections`/`visibleRows` to `sectionsToRender`/`rowsToRender`;
    * CHANGE: Refactor the `displayedRows` to `visibleRows` to be consistent with Apple's framework (visible rows now means the rows that are appearing to the user in the table);
    * ADD: A UITableView extension to use all TableManager features directly in the tableView instance;
    * ADD: A `UIScrollViewDelegate` property to redirect all the scroll events.
## 1.1.0
    * ADD: `selectedRow()` method in TableManger class; 
    * ADD: `displayedRows()` method in TableManger class; - suggestion by [@lfarah](https://github.com/lfarah)
## 1.0.0
    * First official release; 
    * FIX: Swift style code;
    * ADD: Support to Footer configuration;
    * ADD: Section constructor;
    * CHANGE: All API;
    * CHANGE: Remove `stateRows` property;
    * CHANGE: Remove `StateRowsTuple` typealias;
    * CHANGE: Remove `ScreenState` enum;
    * CHANGE: Remove `ConfigureCell` protocol;
## 0.0.3
    * Some fixes;
    * ADD: Example project;
    * FIX: A bug was blocking the usage as pod;
    * FIX: Rename `setByResulsAndErrors()` to `setByResultsAndErrors()`
## 0.0.1
    * Creating pod
