//
//  LastRequest.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLastRequest: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var testType: Int = 0
    @objc dynamic var attemptType: Int = 0
    @objc dynamic var questType: Int = 0
    @objc dynamic var answerType: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update(lastRequestUpdate: UpdateLastRequest) {
        self.date = Date()
        self.testType = lastRequestUpdate.testType.index
        self.questType = lastRequestUpdate.questType.rawValue
        self.answerType = lastRequestUpdate.answerResult.rawValue
        
        switch lastRequestUpdate.attemptType {
        case .firstAttempt:
            self.attemptType = 0
        case let .correctionAttempt(attempt):
            self.attemptType = attempt + 1
        }
    }
}
