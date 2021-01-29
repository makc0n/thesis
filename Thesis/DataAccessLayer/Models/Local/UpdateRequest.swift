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
    
    var completeFast: Int? = nil
    var failFast: Int? = nil
    
//MARK: - Choice
    
    var completeChoice: Int? = nil
    var failChoice: Int? = nil
    
//MARK: - Costructor
    
    var completeConstructor: Int? = nil
    var failConstructor: Int? = nil
    
//MARK: - SimpleInput
    
    var completeInput: Int? = nil
    var failInput: Int? = nil
    
    var completeFirstAttempt: Int? = nil
    var failFirstAttempt: Int? = nil
    
    var completeCorrectionAttempt: Int? = nil
    var failCorrectionAttempt: Int? = nil
    
    init(completeFast: Int? = nil, failFast: Int? = nil,
         completeChoice: Int? = nil, failChoice: Int? = nil,
         completeConstructor: Int? = nil, failConstructor: Int? = nil,
         completeInput: Int? = nil, failInput: Int? = nil,
         completeFirstAttempt: Int? = nil, failFirstAttempt: Int? = nil,
         completeCorrectionAttempt: Int? = nil, failCorrectionAttempt: Int? = nil) {
        
        self.completeFast = completeFast
        self.failFast = failFast
        self.completeChoice = completeChoice
        self.failChoice = failChoice
        self.completeConstructor = completeConstructor
        self.failConstructor = failConstructor
        self.completeInput = completeInput
        self.failInput = failInput
        self.completeFirstAttempt = completeFirstAttempt
        self.failFirstAttempt = failFirstAttempt
        self.completeCorrectionAttempt = completeCorrectionAttempt
        self.failCorrectionAttempt = failCorrectionAttempt

    }
    
    init(complete: Bool, testType: TestType, questType: QuestType, attemptType: AttemptType){
        
        switch questType {
        case .choice:
            self.completeChoice = complete ? 1 : nil
            self.failChoice = complete ? nil : 1
        case .constructor:
            self.completeConstructor = complete ? 1 : nil
            self.failConstructor = complete ? nil : 1
        case .simpleInput:
            self.completeInput = complete ? 1 : nil
            self.failInput = complete ? nil : 1
        default:
            break
        }
        
        if testType == .fast {
            self.completeFast =  complete ? 1 : nil
            self.failFast = complete ? nil : 1
        }
        
        
        if attemptType == .firstAttempt {
            self.completeFirstAttempt = complete ? 1 : nil
            self.failFirstAttempt = complete ? nil : 1
        } else {
            self.completeCorrectionAttempt = complete ? 1 : nil
            self.failCorrectionAttempt = complete ? nil : 1
        }
        
    }
    
}
