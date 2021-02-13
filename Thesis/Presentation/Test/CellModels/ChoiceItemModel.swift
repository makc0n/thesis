//
//  ChoiceItemModel.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class ChoiceItemModel: ViewModel{
    
    let word: Word
    lazy var wordRus = Observable.just(word.rus)
    lazy var wordEng = Observable.just(word.eng)
    
    init(_ word: Word){
        self.word = word
    }
    
    override func subscribe() {
        
        super.subscribe()
    }
    
}
