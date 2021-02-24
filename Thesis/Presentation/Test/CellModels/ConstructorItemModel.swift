//
//  ConstructorItemModel.swift
//  Thesis
//
//  Created by Максим Василаки on 29.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxSwift

class ConstructorItemModel: ViewModel {
    
    let letter: BehaviorRelay<Character>
    let count: BehaviorRelay<Int>
    let failSelect = PublishSubject<Void>()
    
    init(_ letters: [Character] ){
        self.letter = BehaviorRelay<Character>(value: letters.first!)
        self.count = BehaviorRelay(value: letters.count)
    }
    
    func decrementLetter() {
        self.count.accept(self.count.value - 1)
    }
}
