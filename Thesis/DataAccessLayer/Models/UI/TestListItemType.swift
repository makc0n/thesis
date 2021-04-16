//
//  TestListItemType.swift
//  Thesis
//
//  Created by Максим Василаки on 07.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import Foundation

enum TestListItemType {
    
    case fast
    case fastSettings
    case lastPattern
    case patterns
    case trainingProgram
    case notificationSettings
    
    var title: String {
        
        switch self {
        case .fast: return "Быстрый тест"
        case .fastSettings: return "Настройки быстрого теста"
        case .lastPattern: return "Последний тест"
        case .patterns: return "Свои шаблоны"
        case .trainingProgram: return "Программа тренеровок"
        case .notificationSettings: return "Интерактивных уведомлений"
        }
        
    }
    
    static var all: [TestListItemType] = [.fast, .fastSettings, .lastPattern, .patterns, .trainingProgram, .notificationSettings]
    
}
