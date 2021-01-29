//
//  StatisticItemModel.swift
//  Thesis
//
//  Created by Максим Василаки on 03.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa

class StatisticItemModel: ViewModel{
    
    let title : BehaviorRelay<String>
    let value : BehaviorRelay<String>
    
    init(_ title:String, _ value:String){
        self.title = BehaviorRelay<String>(value: title)
        self.value = BehaviorRelay<String>(value: value)

    }
    
    override func subscribe() {
        
        super.subscribe()
    }
}
