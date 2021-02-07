//
//  TestType.swift
//  Thesis
//
//  Created by Максим Василаки on 31.01.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit

enum TestType: Equatable {
    
    case fast(wordIDs: [Int] = [])
    case onlyChoice(wordIDs: [Int] = [])
    case onlyConstructor(wordIDs: [Int] = [])
    case onlySimpleInput(wordIDs: [Int] = [])
    case custom(quests: [Quest], countWords: Int, wordIDs: [Int] = [])
    
    
    var questTypes: [QuestType] {
        switch self {
        case let .fast(wordIDs):
            let types: [QuestType] = [ .choice, .constructor, .simpleInput]
            return wordIDs.isEmpty ? [.preview] + types  : types
        case let .onlyChoice(wordIDs):
            return wordIDs.isEmpty ? [.preview, .choice] : [.choice]
        case let .onlyConstructor(wordIDs):
            return wordIDs.isEmpty ? [.preview, .constructor] : [.constructor]
        case let .onlySimpleInput(wordIDs):
            return wordIDs.isEmpty ? [.preview, .simpleInput] : [.simpleInput]
        case let .custom(quests, _, _): return quests.map({$0.questType})
        }
    }
    
    var quests: [Quest] {
        switch self {
        case let .custom(quests, _ , _):
            return quests
        default:
            return self.questTypes.map({ Quest(questType: $0) })
        }
    }
    
    var wordsCountNeeded: Int {
        switch self {
        case let .custom(_, countWords, _):
            return countWords
        default:
            return 5
        }
    }
    
    var wordsIDs: [Int] {
        switch self {
        case let .fast(wordIDs),let .onlyChoice(wordIDs),let .onlySimpleInput(wordIDs),let .onlyConstructor(wordIDs),let .custom(_,_,wordIDs):
            return wordIDs
        }
    }
    
    var index: Int {
        switch self {
        case .fast: return 0
        case .onlyChoice: return 1
        case .onlyConstructor: return 2
        case .onlySimpleInput: return 3
        case .custom: return 4
        }
    }
    
    static func fromIndex(index: Int) -> TestType {
        switch index {
        case 0: return .fast()
        case 1: return .onlyChoice()
        case 2: return .onlyConstructor()
        case 3: return .onlySimpleInput()
        default: return .custom(quests: [], countWords: 5, wordIDs: [])
        }
    }
    
    static func == (lhs: TestType, rhs: TestType) -> Bool {
        return lhs.index == rhs.index
    }
    
}
