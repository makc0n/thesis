//
//  TestSettings.swift
//  Thesis
//
//  Created by Максим Василаки on 19.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class Quest {
    
    let disposeBag = DisposeBag()
    let trainer = Trainer.instance
    
    let attemptCount: Int
    let questType: QuestType
    let testType: TestType
        
    var attemptType: AttemptType
    
    init(questType: QuestType, testType: TestType, attemptCount: Int = 3){
        self.questType = questType
        self.testType = testType
        self.attemptType = .firstAttempt
        self.attemptCount = attemptCount
    }
    
    
    func sendAnswer(wordID: String, answerType: AnswerType) {
        let score = trainer.scoreAddition[answerType.rawValue] * computeMultiplication()
        let priority = trainer.priorityAddition[answerType.rawValue] * computeMultiplication()
        
        UpdateWordByQuest.default.use(input: UpdateWordByQuest.Input(wordID: wordID, completed: answerType != .uncorrect, score: score, priority: priority, testType: testType, questType: questType, attemptType: attemptType)).subscribe().disposed(by: disposeBag)
        if (answerType == .uncorrect) {
            attemptType = .correctionAttempt
        }
    }
    
    private func computeMultiplication() -> Double {
        var multiplication = 1.0
        
        multiplication -= trainer.questTypeMultiplicates[questType.rawValue]
        if testType == .fast {
            multiplication -= trainer.answerTypeMultiplicates[questType.rawValue]
        }
        
        multiplication *= trainer.attemptMultiplicates[attemptType.rawValue]
        
        return multiplication
    }
    
    
    
    
}

enum QuestType: Int {
    
    case preview = 0
    case choice
    case constructor
    case simpleInput
    
    func quest(testType: TestType) -> Quest {
        return Quest(questType: self, testType: testType)
    }
    
}

enum AttemptType: Int {
    
    case firstAttempt = 0
    case correctionAttempt
    
}

enum AnswerType: Int {
    case correct
    case uncorrect
    case synonym
}


