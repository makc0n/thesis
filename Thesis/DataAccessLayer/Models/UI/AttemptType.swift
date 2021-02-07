//
//  AttemptType.swift
//  Thesis
//
//  Created by Максим Василаки on 31.01.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import Foundation

enum AttemptType {
    
    case firstAttempt
    case correctionAttempt(attempt: Int)
    
    
    var index: Int {
        switch self {
        case .firstAttempt: return 0
        case let .correctionAttempt(attempt): return attempt
        }
    }
    
    static func fromIndex(index: Int) -> AttemptType {
        if index == 0 {
            return .firstAttempt
        } else {
            return correctionAttempt(attempt: index + 1 )
        }
    }
    
}
