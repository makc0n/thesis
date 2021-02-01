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
    
    func getWord(wordID: Int) -> Observable<Word>
    func getWords(wordsIDs: [Int]) -> Observable<[Word]>
    func getAllWords() -> Observable<[Word]>
    
    func addWord(word: Word) -> Single<Int>
    func addWords(words: [Word]) -> Single<[Int]>
    
    func updateWord(rus: String?, eng: String?, transcription: String?, wordID: Int) -> Single<Void>
    func updateWordByQuest(wordID: Int, score: Double, priority: Double, answerResult: AnswerResult, testType: TestType, questType: QuestType, attemptType: AttemptType) -> Single<Void>
//    func updateRequest(wordID: String, score: Double, priority: Double, updateRequest: UpdateRequest) -> Single<Void>
//    func updateLastRequest(wordID: String, lastRequest: LastRequest) -> Single<Void>
    func addSynonyms(synonymsIDs: [Int], for wordID: Int) -> Single<Void>
    func removeSynonym(synonymID: Int, wordID: Int) -> Single<Void>
    
    func removeWord(wordID: Int) -> Single<Void>
}
