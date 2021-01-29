//
//  LastRequest.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLastRequest:Object,RealmIdentifiableType {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var testType: Int = 0
    @objc dynamic var attemptType: Int = 0
    @objc dynamic var questType: Int = 0
    @objc dynamic var complete: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update(lastRequestUpdate: UpdateLastRequest) {
        self.date = Date()
        self.testType = lastRequestUpdate.testType.rawValue
        self.attemptType = lastRequestUpdate.attemptType.rawValue
        self.questType = lastRequestUpdate.questType.rawValue
        self.complete = lastRequestUpdate.complete
    }
}
