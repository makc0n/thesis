//
//  Trainer.swift
//  Thesis
//
//  Created by Максим Василаки on 08.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import CleanMapper
import RxSwift

fileprivate let defaultTestTypeMultiplicates = [0.5, 0.3, 0.15, 0.0]
fileprivate let defaultQuestTypeMultiplicates = [0.0, 0.3, 0.15, 0.0]
fileprivate let defaultAttempTypeMultiplicates = [0.0, 0.1]
fileprivate let defaultAnswerResultMultiplicates = [1.0, 0.8, 0.5]
fileprivate let defaultPriorityAddition = 10.0
fileprivate let defaultScoreAddition = 10.0
fileprivate let defaultLastRequest = [1.0, 0.8, 5.0]
fileprivate let defaultDaysScoreMultiplication = 0.25
fileprivate let defaultPriorityMinimum = 0
fileprivate let defaultStepPriorityIncrease = 1

class Trainer {
    
    static let instance = Trainer()
    private let standarDefaults = UserDefaults.standard
    private let disposeBag = DisposeBag()
    
    private(set) var testTypeMultiplicates: [Double] = defaultTestTypeMultiplicates
    private(set) var questTypeMultiplicates: [Double] = defaultQuestTypeMultiplicates
    private(set) var attemptTypeMultiplicates: [Double] = defaultAttempTypeMultiplicates
    private(set) var answerResultMultiplicates: [Double] = defaultAnswerResultMultiplicates
    private(set) var scoreAddition: Double = defaultScoreAddition
    private(set) var priorityAddition: Double = defaultPriorityAddition
    private(set) var lastRequest: [Double] = defaultLastRequest
    private(set) var daysScoreMultiplication: Double = defaultDaysScoreMultiplication
    private(set) var priorityMinnimum: Int = defaultPriorityMinimum
    private(set) var stepPriorityIncrease: Int = defaultStepPriorityIncrease
    
    
    
    private init(){
        if standarDefaults.bool(forKey: StorageKeys.initialized.key) {
            loadDefaulds()
        } else {
            createDefaulds()
        }
    }
    
    private func loadDefaulds(){
        self.testTypeMultiplicates = (standarDefaults.array(forKey: StorageKeys.testType.key) as? [Double]) ?? defaultTestTypeMultiplicates
        self.questTypeMultiplicates = (standarDefaults.array(forKey: StorageKeys.questType.key) as? [Double]) ?? defaultQuestTypeMultiplicates
        self.attemptTypeMultiplicates = (standarDefaults.array(forKey: StorageKeys.attemptType.key) as? [Double]) ?? defaultAttempTypeMultiplicates
        self.answerResultMultiplicates = (standarDefaults.array(forKey: StorageKeys.answerResult.key) as? [Double]) ?? defaultAnswerResultMultiplicates
        
        self.scoreAddition = standarDefaults.double(forKey: StorageKeys.scoreAddition.key)
        self.priorityAddition = standarDefaults.double(forKey: StorageKeys.priorityAddition.key)
        
        self.lastRequest = (standarDefaults.array(forKey: StorageKeys.lastRequest.key) as? [Double]) ?? defaultLastRequest
        self.daysScoreMultiplication = standarDefaults.double(forKey: StorageKeys.daysScore.key)
        self.priorityMinnimum = standarDefaults.integer(forKey: StorageKeys.priorityMinimum.key)
        self.stepPriorityIncrease = standarDefaults.integer(forKey: StorageKeys.stepPriorityIncrease.key)
        
    }
    
    private func createDefaulds(){
        standarDefaults.set(true, forKey: StorageKeys.initialized.key )
        standarDefaults.set(defaultTestTypeMultiplicates, forKey: StorageKeys.testType.key)
        standarDefaults.set(defaultQuestTypeMultiplicates, forKey: StorageKeys.questType.key)
        standarDefaults.set(defaultAttempTypeMultiplicates, forKey: StorageKeys.attemptType.key)
        standarDefaults.set(defaultAnswerResultMultiplicates, forKey: StorageKeys.answerResult.key)
        standarDefaults.set(defaultScoreAddition, forKey: StorageKeys.scoreAddition.key)
        standarDefaults.set(defaultPriorityAddition, forKey: StorageKeys.priorityAddition.key)
        standarDefaults.set(defaultLastRequest, forKey: StorageKeys.lastRequest.key)
        standarDefaults.set(daysScoreMultiplication, forKey: StorageKeys.daysScore.key)
        standarDefaults.set(defaultPriorityMinimum, forKey: StorageKeys.priorityMinimum.key)
        standarDefaults.set(defaultStepPriorityIncrease, forKey: StorageKeys.stepPriorityIncrease.key)

    }
    
    func consulidateResults(word: Word, testType: TestType, questType: QuestType, attempt: AttemptType, answer: String) -> AnswerResult {
        let multiplication = self.computeMultiplication(testType: testType, questType: questType, attemptType: attempt)
        let result = questType == .constructor ? computeConstructorConcurrence(word: word, answer: answer) : computeConcurrence(word: word, withAnswer: answer)
        let score = scoreAddition * multiplication * answerResultMultiplicates[result.rawValue]
        let priority = priorityAddition * multiplication * answerResultMultiplicates[result.rawValue]
        
        UpdateWordByQuest.default.use(input: .init(wordID: word.id, score: score, priority: priority, answerResult: result, testType: testType, questType: questType, attemptType: attempt)).subscribe().disposed(by: disposeBag)
        
        return result
    }
    
    private func computeConstructorConcurrence(word: Word, answer: String) -> AnswerResult {
        
        return word.translate.lowercased().hasPrefix(answer.lowercased()) ? .correct : .uncorrect
    }
    
    private func computeConcurrence( word: Word, withAnswer answer: String) -> AnswerResult {
        
        let original = word.translate.trimmingCharacters(in: .whitespaces).lowercased()
        let input = answer.trimmingCharacters(in: .whitespaces).lowercased()
        if original == input { return .correct }
        
        let realm = Realms.words.create()
        let synonyms: [Word] = realm.objects(RealmWord.self).filter("id IN %@", word.synonymsID).map(Mapper.map)
        
        if synonyms.contains(where: { $0.translate.trimmingCharacters(in: CharacterSet(charactersIn: " ")).lowercased() == input }) { return .synonym}
        
        return .uncorrect
    }
    
    private func computeMultiplication(testType: TestType, questType: QuestType, attemptType: AttemptType) -> Double {
        var multiplication = 1.0
        
        switch testType {
        case let .custom(quests, _, _):
            let avg = quests.map({$0.questType.rawValue}).avg()
            multiplication -= self.testTypeMultiplicates[avg]
        default:
            multiplication -= self.testTypeMultiplicates[testType.index]
        }
        
        multiplication -= questTypeMultiplicates[questType.rawValue]
        
        switch attemptType {
        case .firstAttempt:
            multiplication -= attemptTypeMultiplicates[0]
        case let .correctionAttempt(attempt):
            multiplication -= attemptTypeMultiplicates[1] * Double(attempt)
        }
        
        return multiplication
        
    }
    
}


fileprivate enum StorageKeys: String {
    
    case initialized
    case testType
    case questType
    case attemptType
    case answerResult
    case scoreAddition
    case priorityAddition
    case lastRequest
    case daysScore
    case priorityMinimum
    case stepPriorityIncrease
    
    var key: String {
        return "TrainerKeyFor_" + self.rawValue
    }
}
