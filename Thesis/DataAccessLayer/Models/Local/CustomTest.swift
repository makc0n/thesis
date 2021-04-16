//
//  CustomTest.swift
//  Thesis
//
//  Created by Максим Василаки on 16.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import Foundation
struct CustomTest {
    
    let id: Int
    let name: String
    let wordsCountInRequest: Int
    let attemptCount: Int
    let synonymIsEnable: Bool
    
    let questsQueue: [Int: QuestType]
    let wordIDs: [Int]
    let collectionIDs: [Int]
    
}
