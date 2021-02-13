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
    
    let testType: TestType
    lazy var usedWordsIDs: [Int] = self.testType.wordsIDs
    private lazy var wordsCountNeeded: Int = self.testType.wordsCountNeeded
    private lazy var quests: [Quest] = self.testType.quests
    private(set) var words: [Word]
    private var stats = [ Int : TestStatistic ]()
    var currentQuest: Quest!
    
    init(testType: TestType){
        self.testType = testType
        self.words = []
    }
    
    func appendWord(_ word: Word) {
        if self.words.count < self.wordsCountNeeded {
            self.words.append(word)
        } else {
            self.nextQuest()
        }
    }
    
    func verifyAnswer(wordID: Int, answer: String, attempt: AttemptType) -> AnswerResult {
        guard let word = words.first(where: {$0.id == wordID}) else { return .uncorrect }
        
        return Trainer.instance.consulidateResults(word: word, testType: testType, questType: currentQuest.questType, attempt: attempt, answer: answer)
    }
    
    func nextQuest() {
        
        if quests.isEmpty {
            Navigator.navigate(route: NavigationRoutes.replaceEndTest(testConfiguration: self) )
            return
        }
    
        self.currentQuest = self.quests.removeFirst()
        
        switch self.currentQuest.questType {
        case .preview:
            if self.words.isEmpty {
                Navigator.navigate(route: NavigationRoutes.pushPreTest(testConfiguration: self))
            } else {
                self.words = []
                Navigator.navigate(route: NavigationRoutes.replacePreTest(testConfiguration: self))
            }
        case .choice:
            Navigator.navigate(route: NavigationRoutes.replaceChoiceTest(testConfiguration: self))
        case .constructor:
            Navigator.navigate(route: NavigationRoutes.replaceConstructor(testConfiguration: self))
        case .simpleInput:
            Navigator.navigate(route: NavigationRoutes.replaceSimpleInput(testConfiguration: self))
        }
        
    }
    
    
}


