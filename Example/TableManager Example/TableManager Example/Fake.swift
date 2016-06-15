//
//  Fake.swift
//  TableManager Example
//
//  Created by Henrique Morbin on 14/06/16.
//  Copyright © 2016 Morbix. All rights reserved.
//

import Foundation

struct Fake {
    
    static func basicData() -> [String] {
        return (1...100).map { "Row \($0)" }
    }
    
    static func sectionsAndRowsData() -> DataColletion {
        
        let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
        
        var data: DataColletion = []
        
        alphabet.forEach { sectionLetter in
            
            let section = "Section " + sectionLetter
            
            let rows = alphabet.map { rowLetter in
                "Row " + rowLetter
            }
            
            data.append((section, rows))
        }
        
        return data
    }
    
    typealias DataColletion = [(section: String, rows: [String])]
}
