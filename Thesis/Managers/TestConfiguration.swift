//
//  QuestSettings.swift
//  Thesis
//
//  Created by Максим Василаки on 30.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM

class TestConfiguration {
    
    let testType: TestType
    let neededWordsCount: Int    
    let attempCount: Int
    let usedWordsIDs: [String]
    private(set) var words: [Word]
    private var quests: [Quest]
    let `quests`: [Quest]
    lazy var currentQuest: Quest = quests.first!
    
    init(testType: TestType = .fast, usedWordsIDs: [String] = [], words: [Word] = [], neededWordsCount: Int = 3, attemptCount: Int = 2, quests: [Quest] = []){
        
        self.neededWordsCount = neededWordsCount
        self.attempCount = attemptCount
        self.testType = testType
        self.words = words
        self.quests = quests.isEmpty ? [QuestType.preview, .choice, .constructor, .simpleInput].map({$0.quest(testType: testType)}) : quests
        self.`quests` = self.quests
        self.usedWordsIDs = usedWordsIDs
        
    }
    
    func appendWord(_ word: Word) {
        if self.words.count < self.neededWordsCount {
            self.words.append(word)
        } else {
            self.nextQuest()
        }
    }
    
    func beginTest() {
        guard let questType = self.quests.first?.questType else {
            return
        }
        
        switch questType {
        case .preview:
            Navigator.navigate(route: NavigationRoutes.pushPreTest(usedWordsIDs: self.usedWordsIDs, testConfiguration: self))
        case .choice:
            Navigator.navigate(route: NavigationRoutes.pushChoiceTest(words: self.words, testConfiguration: self))
        case .constructor:
            Navigator.navigate(route: NavigationRoutes.pushConstructor(words: self.words, testConfiguration: self))
        case .simpleInput:
            Navigator.navigate(route: NavigationRoutes.pushSimpleInput(words: self.words, testConfiguration: self))
        }
        
    }
    
    func nextQuest() {
        
        if quests.isEmpty {
            Navigator.navigate(route: NavigationRoutes.replaceEndTest)
            return
        }
    
        self.currentQuest = self.quests.removeFirst()
        
        switch self.currentQuest.questType {
        case .preview:
            self.words = []
            Navigator.navigate(route: NavigationRoutes.replacePreTest(usedWordsIDs: self.usedWordsIDs, testConfiguration: self))
        case .choice:
            Navigator.navigate(route: NavigationRoutes.replaceChoiceTest(words: self.words, testConfiguration: self))
        case .constructor:
            Navigator.navigate(route: NavigationRoutes.replaceConstructor(words: self.words, testConfiguration: self))
        case .simpleInput:
            Navigator.navigate(route: NavigationRoutes.replaceSimpleInput(words: self.words, testConfiguration: self))
        }
        
    }
    
    
}

enum TestType: Int {
    
    case fast = 0
    case onlyChoice
    case onlyConstructor
    case onlySimpleInput
    case custom
    
}
