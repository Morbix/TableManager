//
//  ScrollViewDelegateViewController.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 19/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import UIKit

class ScrollViewDelegateViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Fake.basicData().forEach { element in
            tableView.addRow().setConfiguration { (row, cell, indexPath) in
                cell.textLabel?.text = element
            }
        }
        
        tableView.reloadData()
        
        tableView.scrollViewDelegate = self
    }
    
}

extension ScrollViewDelegateViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
    }
    
}
