//
//  RealmRequest.swift
//  Thesis
//
//  Created by Максим Василаки on 15.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRequest: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    
//MARK: - Fast
    @objc dynamic var completeFast: Int = 0
    @objc dynamic var failFast: Int = 0
    
//MARK: - Choice
    @objc dynamic var completeChoice: Int = 0
    @objc dynamic var failChoice: Int = 0
    
//MARK: - Costructor
    @objc dynamic var completeConstructor: Int = 0
    @objc dynamic var failConstructor: Int = 0
    
//MARK: - SimpleInput
    @objc dynamic var completeInput: Int = 0
    @objc dynamic var failInput: Int = 0
    @objc dynamic var synonyms: Int = 0
    
    @objc dynamic var completeFirstAttempt: Int = 0
    @objc dynamic var failFirstAttempt: Int = 0
    
    @objc dynamic var completeCorrectionAttempt: Int = 0
    @objc dynamic var failCorrectionAttempt: Int = 0

            
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func update( updateRequest: UpdateRequest) {
        //Fast
        if updateRequest.completeFast {
            self.completeFast += 1
        }
        
        if updateRequest.failFast {
            self.failFast += 1
        }
        
        //Choice
        if updateRequest.completeChoice {
            self.completeChoice += 1
        }
        
        if updateRequest.failChoice {
            self.failChoice += 1
        }
        
        //Costructor
        if updateRequest.completeConstructor {
            self.completeConstructor += 1
        }
        
        if updateRequest.failConstructor {
            self.failConstructor += 1
        }
        
        //SimpleInput
        if updateRequest.completeInput {
            self.completeInput += 1
        }
        
        if updateRequest.failInput {
            self.failInput += 1
        }
        
        if updateRequest.synonym {
            self.synonyms += 1
        }
        
        //Attempt
        if updateRequest.completeFirstAttempt {
            self.completeFirstAttempt += 1
        }
        
        if updateRequest.failFirstAttempt {
            self.failFirstAttempt += 1
        }
        
        if updateRequest.completeCorrectionAttempt {
            self.completeCorrectionAttempt += 1
        }
        
        if updateRequest.failCorrectionAttempt {
            self.failCorrectionAttempt += 1
        }
    }
}
