//
//  RealmRequest.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRequest:Object,RealmIdentifiableType {
    
    @objc dynamic var id:String = UUID().uuidString
    
//MARK: - Fast
    @objc dynamic var completeFast:Int = 0
    @objc dynamic var failFast:Int = 0
    
//MARK: - Choice
    @objc dynamic var completeChoice:Int = 0
    @objc dynamic var failChoice:Int = 0
    
//MARK: - Costructor
    @objc dynamic var completeConstructor:Int = 0
    @objc dynamic var failConstructor:Int = 0
    
//MARK: - SimpleInput
    @objc dynamic var completeInput:Int = 0
    @objc dynamic var failInput:Int = 0
    
    @objc dynamic var completeFirstAttempt:Int = 0
    @objc dynamic var failFirstAttempt:Int = 0
    
    @objc dynamic var completeCorrectionAttempt:Int = 0
    @objc dynamic var failCorrectionAttempt:Int = 0

            
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update( updateRequest: UpdateRequest) {
        //Fast
        if let completeFast = updateRequest.completeFast {
            self.completeFast += completeFast
        }
        
        if let failFast = updateRequest.failFast {
            self.failFast += failFast
        }
        
        //Choice
        if let completeChoice = updateRequest.completeChoice {
            self.completeChoice += completeChoice
        }
        
        if let failChoice = updateRequest.failChoice {
            self.failChoice += failChoice
        }
        
        //Costructor
        if let completeConstructor = updateRequest.completeConstructor {
            self.completeConstructor += completeConstructor
        }
        
        if let failConstructor = updateRequest.failConstructor {
            self.failConstructor += failConstructor
        }
        
        //SimpleInput
        if let completeInput = updateRequest.completeInput {
            self.completeInput += completeInput
        }
        
        if let failInput = updateRequest.failInput {
            self.failInput += failInput
        }
        
        //Attempt
        if let completeFirstAttempt = updateRequest.completeFirstAttempt {
            self.completeFirstAttempt += completeFirstAttempt
        }
        
        if let failFirstAttempt = updateRequest.failFirstAttempt {
            self.failFirstAttempt += failFirstAttempt
        }
        
        if let completeCorrectionAttempt = updateRequest.completeCorrectionAttempt {
            self.completeCorrectionAttempt += completeCorrectionAttempt
        }
        
        if let failCorrectionAttempt = updateRequest.failCorrectionAttempt {
            self.failCorrectionAttempt += failCorrectionAttempt
        }
    }
}
