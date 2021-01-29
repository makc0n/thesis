//
//  Word.swift
//  Thesis
//
//  Created by Максим Василаки on 20.08.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

struct Word {
    
    let id: String
    var rus: String
    var eng: String
    var transcription: String
    var imageURL: String
    var score: Double
    var priority: Double
    let request: Request
    let lastRequest: LastRequest?
    
    var synonymsID: [String]
    
    static func defaultWord() -> Word {
        return Word(id: UUID().uuidString,
                    rus: "",
                    eng: "",
                    transcription: "",
                    imageURL: "",
                    score: 0.0,
                    priority: 0.0,
                    request: Request.defaultRequest(),
                    lastRequest: nil,
                    synonymsID: [])
    }
    
}
