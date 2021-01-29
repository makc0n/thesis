//
//  Date.swift
//  Thesis
//
//  Created by Максим Василаки on 07.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    var containedDays:Int {
        return Int(self.timeIntervalSince1970 / 86400.0)
    }
    
    var daysAgo: Int {
        return Date().containedDays - self.containedDays
    }
}
