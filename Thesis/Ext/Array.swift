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

extension Array where Element: Hashable {
    
    func groupping() -> [[Element]] {
        let temp = Set(self)
        var result = [[Element]]()
        
        for element in temp {
            let count = self.filter({ $0 == element }).count
            result.append(Array(repeating: element, count: count))
        }
        
        return result
    }
}
