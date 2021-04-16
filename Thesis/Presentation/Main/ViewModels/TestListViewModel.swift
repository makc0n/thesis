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
import RxCocoa
import RxDataSources

class TestListViewModel: ViewModel{
    
    
    
    private let itemViewModel = Observable.just(TestListItemType.all.map(TestListItemViewModel.init) )
    lazy var sections = itemViewModel.map({ [SectionModel<String, TestListItemViewModel>(model: "", items: $0)] })
        
    override func subscribe() {
        super.subscribe()
        
        
        
    }
    
    private func fastTest(wordsID: [Int]){
        let test = Test(testType: .fast(wordIDs: wordsID))
        test.nextQuest()
    }
}
