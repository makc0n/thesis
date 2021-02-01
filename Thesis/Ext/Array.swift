//
//  Array.swift
//  Thesis
//
//  Created by Максим Василаки on 31.01.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit

extension Array where Element == Int {
    
    func avg() -> Int {
        let sum = self.reduce(0, +)
        return sum / self.count
    }
    
}
