//
//  Collection.swift
//  Thesis
//
//  Created by Максим Василаки on 13.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

struct Collection {
    let id: Int
    var name: String
    var completed: Int
    var count: Int { self.wordsIDs.count }
    var wordsIDs: [Int]
    
    static func defaultCollection() -> Collection {
        return Collection(id: Int(arc4random()), name: "", completed: 0, wordsIDs: [])
    }
}
