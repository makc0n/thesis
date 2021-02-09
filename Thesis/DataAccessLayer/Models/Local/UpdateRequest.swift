//
//  UpdateRequest.swift
//  Thesis
//
//  Created by Максим Василаки on 29.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

struct UpdateRequest {
    
//MARK: - Fast
    
    var completeFast: Bool = false
    var failFast: Bool = false
    
//MARK: - Choice
    
    var completeChoice: Bool = false
    var failChoice: Bool = false
    
//MARK: - Costructor
    
    var completeConstructor: Bool = false
    var failConstructor: Bool = false
    
//MARK: - SimpleInput
    
    var completeInput: Bool = false
    var failInput: Bool = false
    var synonym: Bool = false
    
    var completeFirstAttempt: Bool = false
    var failFirstAttempt: Bool = false
    
    var completeCorrectionAttempt: Bool = false
    var failCorrectionAttempt: Bool = false
    
    init( testType: TestType, questType: QuestType, attemptType: AttemptType, answerResult: AnswerResult ){
        let complete = answerResult == .correct
        let fail = answerResult == .uncorrect
        
        switch questType {
        case .choice:
            self.completeChoice = complete
            self.failChoice = fail
        case .constructor:
            self.completeConstructor = complete
            self.failConstructor = fail
        case .simpleInput:
            self.completeInput = complete
            self.failInput = fail
            self.synonym = answerResult == .synonym
        default:
            break
        }
        
        switch testType {
        case .fast:
            self.completeFast =  complete
            self.failFast = fail
        default:
            break
        }
        
        switch attemptType {
        case .firstAttempt:
            self.completeFirstAttempt = complete
            self.failFirstAttempt = fail
        default:
            self.completeCorrectionAttempt = complete
            self.failCorrectionAttempt = fail
        }
        
        
        
    }
    
}
