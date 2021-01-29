//
//  Trainer.swift
//  Thesis
//
//  Created by Максим Василаки on 08.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

fileprivate let TrainerKeyForInitialized: String = "TrainerKeyForInitialized"
fileprivate let TrainerKeyForQuestType: String = "TrainerKeyForQuestType"
fileprivate let TrainerKeyForAnswerType: String = "TrainerKeyForAnswerType"
fileprivate let TrainerKeyForAttempt: String = "TrainerKeyForAttempt"
fileprivate let TrainerKeyForScoreAddition: String = "TrainerKeyForScoreAddition"
fileprivate let TrainerKeyForPriorityAddition: String = "TrainerKeyForPriorityAddition"
fileprivate let TrainerKeyForLastRequest: String = "TrainerKeyForLastRequest"
fileprivate let TrainerKeyForPriorityMinimum : String = "TrainerKeyForPriorityMinimum"
fileprivate let TrainerKeyForStepPriorityIncrease : String = "TrainerKeyForStepPriorityIncrease"


fileprivate let defaultQuestTypeMultiplicates = [0.5,0.3,0.15,0.0]
fileprivate let defaultAnswerTypeMultiplicates = [0.0,0.3,0.15,0.0]
fileprivate let defaultAttemptMultiplicates = [1.2,0.8]
fileprivate let defaultPriorityAddition = [10.0, 5.0, 8.0]
fileprivate let defaultScoreAddition = [10.0, 5.0, 8.0]
fileprivate let defaultLastRequest = [5.0,3.0,10.0]
fileprivate let defaultPriorityMinimum = 0
fileprivate let defaultStepPriorityIncrease = 1

class Trainer {
    static let instance = Trainer()
    private let standarDefaults = UserDefaults.standard
    
    private(set) var questTypeMultiplicates:[Double] = defaultQuestTypeMultiplicates
    private(set) var answerTypeMultiplicates:[Double] = defaultAnswerTypeMultiplicates
    private(set) var attemptMultiplicates:[Double] = defaultAttemptMultiplicates
    private(set) var scoreAddition: [Double] = defaultScoreAddition
    private(set) var priorityAddition: [Double] = defaultPriorityAddition
    private(set) var lastRequest:[Double] = defaultLastRequest
    private(set) var priorityMinnimum:Int = defaultPriorityMinimum
    private(set) var stepPriorityIncrease:Int = defaultStepPriorityIncrease
    
    
    
    private init(){
        if(standarDefaults.bool(forKey: TrainerKeyForInitialized)){
            loadDefaulds()
        }else{
            createDefaulds()
        }
    }
    
    private func loadDefaulds(){
        self.questTypeMultiplicates = (standarDefaults.array(forKey: TrainerKeyForQuestType) as? [Double]) ?? defaultQuestTypeMultiplicates
        self.answerTypeMultiplicates = (standarDefaults.array(forKey: TrainerKeyForAnswerType) as? [Double]) ?? defaultAnswerTypeMultiplicates
        self.attemptMultiplicates = (standarDefaults.array(forKey: TrainerKeyForAttempt) as? [Double]) ?? defaultAttemptMultiplicates
        
        self.scoreAddition = (standarDefaults.array(forKey: TrainerKeyForScoreAddition) as? [Double]) ?? defaultScoreAddition
        self.priorityAddition = (standarDefaults.array(forKey: TrainerKeyForPriorityAddition) as? [Double]) ?? defaultPriorityAddition
        
        self.lastRequest = (standarDefaults.array(forKey: TrainerKeyForLastRequest) as? [Double]) ?? defaultLastRequest
        self.priorityMinnimum = standarDefaults.integer(forKey: TrainerKeyForPriorityMinimum)
        self.stepPriorityIncrease = standarDefaults.integer(forKey: TrainerKeyForStepPriorityIncrease) == 0 ? 1 : standarDefaults.integer(forKey: TrainerKeyForStepPriorityIncrease)
        print(description())
        
    }
    
    private func createDefaulds(){
        standarDefaults.set(true, forKey: TrainerKeyForInitialized )
        standarDefaults.set(defaultQuestTypeMultiplicates, forKey: TrainerKeyForQuestType)
        standarDefaults.set(defaultAnswerTypeMultiplicates, forKey: TrainerKeyForAnswerType)
        standarDefaults.set(defaultAttemptMultiplicates, forKey: TrainerKeyForAttempt)
        standarDefaults.set(defaultScoreAddition, forKey: TrainerKeyForScoreAddition)
        standarDefaults.set(defaultPriorityAddition, forKey: TrainerKeyForPriorityAddition)
        standarDefaults.set(defaultLastRequest, forKey: TrainerKeyForLastRequest)
        standarDefaults.set(defaultPriorityMinimum, forKey: TrainerKeyForPriorityMinimum)
        standarDefaults.set(defaultStepPriorityIncrease, forKey: TrainerKeyForStepPriorityIncrease)

    }
    
    func description() -> String{
        return "questTypeMultiplicates:\(questTypeMultiplicates)\n" +
        "answerTypeMultiplicates:\(answerTypeMultiplicates)\n" +
        "attemptMultiplicates:\(attemptMultiplicates)\n" +
        "scoreAddition:\(scoreAddition)\n" +
        "priorityAddition:\(priorityAddition) \n" +
        "lastRequest:\(lastRequest)\n" +
        "priorityMinnimum:\(priorityMinnimum)\n" +
        "stepPriorityIncrease:\(stepPriorityIncrease)\n"
    }
    
}
