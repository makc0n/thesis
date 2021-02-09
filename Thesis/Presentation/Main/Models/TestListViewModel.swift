//
//  TestListViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class TestListViewModel: ViewModel{
    
    let words = GetAllWords.default.use().map({$0.words.map({$0.id})})
    let fastTestAction = PublishSubject<Void>()
    
    
    override func subscribe() {
        super.subscribe()
        
        
        fastTestAction.withLatestFrom(words).bind(onNext: { [weak self] ids in
            self?.fastTest(wordsID: ids)
        }).disposed(by: disposeBag)
        
    }
    
    private func fastTest(wordsID: [Int]){
        let test = Test(testType: .fast(wordIDs: wordsID))
        test.nextQuest()
    }
}
