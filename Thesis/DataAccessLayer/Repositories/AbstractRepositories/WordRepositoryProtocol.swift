//
//  WordRepositoryProtocol.swift
//  Thesis
//
//  Created by Максим Василаки on 13.09.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxSwift


protocol WordRepositoryProtocol {
    
    func getWord(wordID: String) -> Observable<Word>
    func getWords(wordsIDs: [String]) -> Observable<[Word]>
    func getAllWords() -> Observable<[Word]> 
    
    func addWord(word: Word) -> Single<String>
    func addWords(words: [Word]) -> Single<[String]>
    
    func updateWord(rus: String?, eng: String?, transcription: String?, wordID: String) -> Single<Void>
    func updateWordByQuest(wordID: String, completed: Bool, score: Double, priority: Double, testType: TestType, questType: QuestType, attemptType: AttemptType) -> Single<Void>
//    func updateRequest(wordID: String, score: Double, priority: Double, updateRequest: UpdateRequest) -> Single<Void>
//    func updateLastRequest(wordID: String, lastRequest: LastRequest) -> Single<Void>
    func addSynonyms(synonymsIDs: [String], for wordID: String) -> Single<Void>
    func removeSynonym(synonymID: String, wordID: String) -> Single<Void>
    
    func removeWord(wordID: String) -> Single<Void>
}
