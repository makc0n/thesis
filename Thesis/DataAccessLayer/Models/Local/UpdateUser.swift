//
//  UpdateUser.swift
//  Thesis
//
//  Created by Максим Василаки on 29.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

struct UpdateUser {
    
    let userName: String?
    let lastVisitDate: Date?
    let stepForPriority: Double?
    
    init( userName: String? = nil, lastVisitDate: Date? = nil, stepForPriority: Double? = nil) {
        self.userName = userName
        self.lastVisitDate = lastVisitDate
        self.stepForPriority = stepForPriority
    }
}
