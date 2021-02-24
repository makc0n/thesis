//
//  WordItemModel.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxSwift

class WordItemModel: ViewModel {
    
    let word: Word
    
    let isEdited = BehaviorRelay<Bool>(value:false)
    var isSelected = BehaviorRelay<Bool>(value: false)
        
    lazy var rus = Observable.just(word.word)
    lazy var eng = Observable.just(word.translate)
    
    init(word: Word) {
        self.word = word
    }
    
    
    override func subscribe() {
        super.subscribe()
    }
    
}
