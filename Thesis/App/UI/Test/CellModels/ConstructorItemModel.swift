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
    
    let letter:BehaviorRelay<Character>
    let failSelect = PublishSubject<Void>()
    let hideCell = PublishSubject<Void>()
    
    init(_ letter:Character){
        self.letter = BehaviorRelay<Character>(value: letter)
    }
    
    override func subscribe() {
        super.subscribe()
    }
}
