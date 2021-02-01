//
//  EndTestViewModel.swift
//  Thesis
//
//  Created by Максим Василаки on 29.04.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift


class EndTestViewModel: ViewModel{
    
    let testConfiguration: Test
    
    let againg = PublishSubject<Void>()
    let done = PublishSubject<Void>()
    
    init( testConfiguration: Test) {
        self.testConfiguration = testConfiguration
    }
    
    override func subscribe() {
        
        againg.bind(onNext: againAction).disposed(by: disposeBag)
        done.bind(onNext: doneAction).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    
    private func againAction(){
        var newTestConfiguration = Test(testType: testConfiguration.testType, words: <#T##[Word]#>, neededWordsCount: testConfiguration.neededWordsCount, attemptCount: testConfiguration.attempCount, quests: [])
        
        
        Navigator.navigate(route: NavigationRoutes.replacePreTest(usedWordsIDs: <#T##[String]#>, testConfiguration: <#T##TestConfiguration#>) )
    }
    
    private func doneAction(){
        Navigator.navigate(route: NavigationRoutes.goBack)
    }
}
