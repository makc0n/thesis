//
//  UpdateWordByQuest.swift
//  Thesis
//
//  Created by Максим Василаки on 06.10.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import CleanUseCase

class UpdateWordByQuest: SingleUseCase<UpdateWordByQuest.Input, Void> {
    
    private var repository: WordRepositoryProtocol!
    
    convenience init(repository: WordRepositoryProtocol) {
        self.init(executionSchedule: MainScheduler.asyncInstance)
        self.repository = repository
    }
    
    static var `default`: UpdateWordByQuest {
        return UpdateWordByQuest(repository: WordRepository())
    }
    
    override func createUseCase(input: Input) -> Single<Void> {
        return repository.updateWordByQuest(wordID: input.wordID, completed: input.completed, score: input.score, priority: input.priority, testType: input.testType, questType: input.questType, attemptType: input.attemptType)
    }
    
}

extension UpdateWordByQuest {
    
    
    struct Input {
        let wordID: Int
        let score: Double
        let priority: Double
        let answerResult: AnswerResult
        let testType: TestType
        let questType: QuestType
        let attemptType: AttemptType
        
    }
}
