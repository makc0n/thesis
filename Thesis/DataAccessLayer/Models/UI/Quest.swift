//
//  TestSettings.swift
//  Thesis
//
//  Created by Максим Василаки on 19.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct Quest {
    
    let attemptCount: Int
    let questType: QuestType
    
    init(questType: QuestType, attemptCount: Int = 3){
        self.questType = questType
        self.attemptCount = attemptCount
    }
    
}








