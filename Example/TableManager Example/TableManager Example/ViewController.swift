//
//  ViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 10/01/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit
import TableManager

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var tableManager : TableManager = TableManager(tableView: self.tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Methods
    
    func configTableManager(){
        
        //1 - Adding a section
        tableManager.sections.append(Section())
        
        //2 - Data to fill table
        let data = ["Basic Usage", "Row Selection", "Sections & Rows Visibility", "Custom Cells"]
        
        for value in data {
            
            //3 - Creating a row
            let row = Row(identifier: "CellBasic", object: value) { (object, cell, indexPath) -> Void in
                if let object = object as? String {
                    cell.textLabel?.text = object
                }
            }
            
            //4 - Adding selection handler
            row.didSelectRowAtIndexPath = { (row: Row, tableView: UITableView, indexPath: NSIndexPath) -> Void in
                if let object = row.object as? String {
                    self.showAlert(object)
                }
            }
            
            //5 - Adding this row in table
            tableManager.sections[0].rows.append(row)
        }
        
        //6 - Refreshing table UI
        tableManager.reloadData()
    }
    
    func showAlert(message : String){
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

