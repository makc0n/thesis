//
//  RealmCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCollection: Object, RealmIdentifiableType {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var completed: Int = 0
    @objc dynamic var learnt: Bool {
        return self.completed == self.wordIDs.count
    }
    var wordIDs = List<Int>()

    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}
