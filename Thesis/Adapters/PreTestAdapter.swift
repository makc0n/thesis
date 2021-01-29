//
//  PreTestAdapter.swift
//  Thesis
//
//  Created by Максим Василаки on 27.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
class PreTestAdapter {
    
    static func smartRandomWord(fromWords words: [Word], forUser user: User, ignoreWordIDs: [String] = []) -> Word {
        var increasedPriority = user.averagePriority
        while true {
            if let word = words.randomElement() {
                if (word.priority <= max(user.averagePriority, increasedPriority) || word.score <= user.averageScore) && !ignoreWordIDs.contains(word.id) {
                    return word
                }
            }
            increasedPriority += user.stepForPriority
        }
    }
    
}
