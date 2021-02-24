//
//  MapperConfiguration.swift
//  Thesis
//
//  Created by Максим Василаки on 20.08.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import SwiftyJSON
import CleanMapper

class MapperConfiguration {

    static func configure() {
        
//MARK: - User to RealmUser
        Mapper.register(mappingAlgorithm: {(user: User) -> RealmUser in
            let realmUser = RealmUser()
            realmUser.userName = user.userName
            realmUser.request = Mapper.map(user.request)
            realmUser.countWords = user.countWords
            realmUser.learntWords = user.learntWords
            realmUser.countCollection = user.countCollection
            realmUser.learntCollection = user.learntCollection
            realmUser.lastVisitDate = user.lastVisitDate
            realmUser.averagePriority = user.averagePriority
            realmUser.averageScore = user.averageScore
            realmUser.stepForPriority = user.stepForPriority
            realmUser.totalScore = user.totalScore
            
            return realmUser
        })
        
//MARK: RealmUser to User
        Mapper.register(mappingAlgorithm: {(realmUser: RealmUser) -> User in
            return User(userName: realmUser.userName,
                        request: Mapper.map(realmUser.request),
                        countWords: realmUser.countWords,
                        learntWords: realmUser.learntWords,
                        countCollection: realmUser.countCollection,
                        learntCollection: realmUser.learntCollection,
                        lastVisitDate: realmUser.lastVisitDate,
                        averagePriority: realmUser.averagePriority,
                        averageScore: realmUser.averageScore,
                        stepForPriority: realmUser.stepForPriority,
                        totalScore: realmUser.totalScore)
        })

//MARK: - Word
        Mapper.register(mappingAlgorithm: { (webWord:WebWord) -> Word in
                        
            return Word(id: Int(arc4random()),
                        word: webWord.rus,
                        translate: webWord.eng,
                        transcription: webWord.transcription,
                        imageURL: "",
                        score: 0.0,
                        priority: 0.0,
                        request: Request.defaultRequest(),
                        lastRequest: nil,
                        synonymsID: [])
        })
        
        Mapper.register(mappingAlgorithm: { (word:Word) -> RealmWord in
            let realmWord = RealmWord()
            realmWord.id = word.id
            realmWord.rus = word.word
            realmWord.eng = word.translate
            realmWord.imageURL = word.imageURL
            realmWord.score = word.score
            realmWord.priority = word.priority
            realmWord.request = Mapper.map(word.request)
            realmWord.lastRequest =  Mapper.map(word.lastRequest)
            realmWord.synonymsID.append(objectsIn: word.synonymsID)
            
            return realmWord
        })

        Mapper.register(mappingAlgorithm: { (realmWord:RealmWord) -> Word in
            return Word(id: realmWord.id,
                        word: realmWord.rus,
                        translate: realmWord.eng,
                        transcription: realmWord.transcription,
                        imageURL: realmWord.imageURL,
                        score: realmWord.score,
                        priority: realmWord.priority,
                        request: Mapper.map(realmWord.request),
                        lastRequest: Mapper.map(realmWord.lastRequest),
                        synonymsID: realmWord.synonymsID.toArray())
        })
        
//MARK: - Request
        Mapper.register(mappingAlgorithm: { (realmRequest: RealmRequest?) -> Request in
            if let realmRequest = realmRequest {
                return Request(id: realmRequest.id,
                               completeFast: realmRequest.completeFast,
                               failFast: realmRequest.failFast,
                               completeChoice: realmRequest.completeChoice,
                               failChoice: realmRequest.failChoice,
                               completeConstructor: realmRequest.completeConstructor,
                               failConstructor: realmRequest.failConstructor,
                               completeInput: realmRequest.completeInput,
                               failInput: realmRequest.failInput,
                               completeFirstAttempt: realmRequest.completeFirstAttempt,
                               failFirstAttempt: realmRequest.failFirstAttempt,
                               completeCorrectionAttempt: realmRequest.completeCorrectionAttempt,
                               failCorrectionAttempt: realmRequest.failCorrectionAttempt)
                
            } else {
                return Request.defaultRequest()
            }
        })
        
        Mapper.register(mappingAlgorithm: { (request: Request) -> RealmRequest? in
            let realmRequest = RealmRequest()
            realmRequest.id = request.id
            realmRequest.completeFast = request.completeFast
            realmRequest.failFast = request.failFast
            realmRequest.completeChoice = request.completeChoice
            realmRequest.failChoice = request.failChoice
            realmRequest.completeConstructor = request.completeConstructor
            realmRequest.failConstructor = request.failConstructor
            realmRequest.completeInput = request.completeInput
            realmRequest.failInput = request.failInput
            realmRequest.completeFirstAttempt = request.completeFirstAttempt
            realmRequest.failFirstAttempt = request.failFirstAttempt
            realmRequest.completeCorrectionAttempt = request.completeCorrectionAttempt
            realmRequest.failCorrectionAttempt = request.failCorrectionAttempt            
            
            return realmRequest
        })
        
        Mapper.register(mappingAlgorithm: { (lastRequest: LastRequest?) -> RealmLastRequest? in
            let realmLastRequest = RealmLastRequest()
            if let lastRequest = lastRequest {
                realmLastRequest.id = lastRequest.id
                realmLastRequest.date = lastRequest.date
                realmLastRequest.testType = lastRequest.testType.index
                realmLastRequest.questType = lastRequest.questType.rawValue
                realmLastRequest.attemptType = lastRequest.attepmtType.index
                realmLastRequest.answerType = lastRequest.answerResult.rawValue
            }
            
            return realmLastRequest
        })
        
        Mapper.register(mappingAlgorithm: { (realmLastRequest: RealmLastRequest?) -> LastRequest? in
            if let realmLastRequest = realmLastRequest {
                return LastRequest(id: realmLastRequest.id,
                                   date: realmLastRequest.date,
                                   testType: TestType.fromIndex(index: realmLastRequest.testType),
                                   attepmtType: AttemptType.fromIndex(index: realmLastRequest.attemptType) ,
                                   questType: QuestType(rawValue: realmLastRequest.questType)!,
                                   answerResult: AnswerResult(rawValue: realmLastRequest.answerType) ?? .uncorrect)
            } else {
                return nil
            }            
        })
        
//MARK: - Collections
        Mapper.register(mappingAlgorithm: { (webCollection: WebCollection) -> Collection in
            return Collection(id: Int(arc4random()),
                              name: webCollection.name,
                              completed: 0,
                              wordsIDs: [])
        })
        
        Mapper.register(mappingAlgorithm: { (realmCollection: RealmCollection) -> Collection in
            return Collection(id: realmCollection.id,
                              name: realmCollection.name,
                              completed: realmCollection.completed,
                              wordsIDs: realmCollection.wordIDs.toArray())
        })
        
        Mapper.register(mappingAlgorithm: { (collection: Collection) -> RealmCollection in
            let realmCollection = RealmCollection()
            realmCollection.id = collection.id
            realmCollection.name = collection.name
            realmCollection.completed = collection.completed
            realmCollection.wordIDs.append(objectsIn: collection.wordsIDs)
            
            return realmCollection
        })
        
        
    }
}

