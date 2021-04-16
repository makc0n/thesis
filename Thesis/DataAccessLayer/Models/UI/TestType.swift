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
    case custom(_ customTest: CustomTest)
    
    
    var questTypes: [Int: QuestType] {
        switch self {
        case .fast:
            return [0 : .preview, 1: .choice, 2: .constructor, 3: .simpleInput]
        case let .onlyChoice(wordIDs):
            return wordIDs.isEmpty ? [0 : .preview,1 :  .choice] : [0 : .choice]
        case let .onlyConstructor(wordIDs):
            return wordIDs.isEmpty ? [0 : .preview,1 :  .constructor] : [0 : .constructor]
        case let .onlySimpleInput(wordIDs):
            return wordIDs.isEmpty ? [0 : .preview, 1 : .simpleInput] : [0 : .simpleInput]
        case let .custom(customQuest):
            return customQuest.questsQueue
        }
    }
    
    var quests: [Quest] {
        switch self {
        default:
            return self.questTypes.values.map({ Quest(questType: $0) })
        }
    }
    
    var wordsCountNeeded: Int {
        switch self {
        case let .custom(customTest):
            return customTest.wordsCountInRequest
        default:
            return 5
        }
    }
    
    var wordsIDs: [Int] {
        switch self {
        case let .fast(wordIDs),let .onlyChoice(wordIDs),let .onlySimpleInput(wordIDs),let .onlyConstructor(wordIDs):
            return wordIDs
        case let .custom(customTest): return customTest.wordIDs
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
    
    static func fromIndex(index: Int, customTest: CustomTest? = nil) -> TestType? {
        switch index {
        case 0: return .fast()
        case 1: return .onlyChoice()
        case 2: return .onlyConstructor()
        case 3: return .onlySimpleInput()
        default:
            guard let customTest = customTest else { return nil }
            return .custom(customTest)
        }
    }
    
    static func == (lhs: TestType, rhs: TestType) -> Bool {
        return lhs.index == rhs.index
    }
    
}
