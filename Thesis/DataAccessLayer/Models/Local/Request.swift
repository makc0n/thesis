//
//  Request.swift
//  Thesis
//
//  Created by Максим Василаки on 20.08.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

struct Request {
    
    let id: Int
    
    var requestCount:Int {
        self.completeRequest + self.failRequest
    }
    
    var completeRequest:Int {
        self.completeFast + self.completeChoice + self.completeConstructor + self.completeInput + self.completeCorrectionAttempt
    }
    
    var failRequest:Int{
        self.failFast + self.failChoice + self.failConstructor + self.failInput +  self.failCorrectionAttempt
    }
    
//MARK: - Fast
    var fastRequest:Int {
        self.completeFast + self.failFast
    }
    var completeFast:Int
    var failFast:Int
    
//MARK: - Choice
    var choiceRequest:Int {
        self.failChoice + self.completeChoice
    }
    var completeChoice:Int
    var failChoice:Int
    
//MARK: - Costructor
    var constructorRequest:Int {
        self.completeConstructor + self.failConstructor
    }
    var completeConstructor:Int
    var failConstructor:Int
    
//MARK: - SimpleInput
    var inputRequest:Int {
        self.completeInput + self.failInput
    }
    var completeInput:Int
    var failInput:Int
    
    var firstAttempt:Int {
        self.completeFirstAttempt + self.failFirstAttempt
    }
    var completeFirstAttempt:Int
    var failFirstAttempt:Int
    
    var correctionAttempt:Int {
        self.completeCorrectionAttempt + self.failCorrectionAttempt
    }
    var completeCorrectionAttempt:Int
    var failCorrectionAttempt:Int
        
    static func defaultRequest() -> Request {
        return Request(id: Int(arc4random()),
                       completeFast: 0,
                       failFast: 0,
                       completeChoice: 0,
                       failChoice: 0,
                       completeConstructor: 0,
                       failConstructor: 0,
                       completeInput: 0,
                       failInput: 0,
                       completeFirstAttempt: 0,
                       failFirstAttempt: 0,
                       completeCorrectionAttempt: 0,
                       failCorrectionAttempt: 0)
    }
}
