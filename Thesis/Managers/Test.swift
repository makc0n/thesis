//
//  QuestSettings.swift
//  Thesis
//
//  Created by Максим Василаки on 30.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM

class Test {
    
    private let testType: TestType
    private lazy var usedWordsIDs: [Int] = self.testType.wordsIDs
    private lazy var wordsCountNeeded: Int = self.wordsCountNeeded
    private lazy var quests: [Quest] = self.testType.quests
    private(set) var words: [Word]
    private var stats = [ Int : TestStatistic ]()
    var currentQuest: Quest!
    
    init(testType: TestType){
        self.testType = testType
    }
    
    func appendWord(_ word: Word) {
        if self.words.count < self.wordsCountNeeded {
            self.words.append(word)
        } else {
            self.nextQuest()
        }
    }
    
    func verifyAnswer(wordID: Int, answer: String, attempt: AttemptType) -> AnswerResult {
        
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


