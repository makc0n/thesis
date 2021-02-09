//
//  RealmUser.swift
//  Thesis
//
//  Created by Максим Василаки on 27.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    
    @objc dynamic var userName = ""
    @objc dynamic var request: RealmRequest? = RealmRequest()
    @objc dynamic var countWords: Int = 0
    @objc dynamic var learntWords: Int = 0
    @objc dynamic var countCollection: Int = 0
    @objc dynamic var learntCollection: Int = 0
    @objc dynamic var lastVisitDate: Date = Date()
    @objc dynamic var averagePriority: Double = 0
    @objc dynamic var averageScore: Double = 0
    @objc dynamic var stepForPriority: Double = 3
    @objc dynamic var totalScore: Double = 0

    
    
}
