//
//  WebCollection.swift
//  Thesis
//
//  Created by Максим Василаки on 09.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation


class WebCollection: Decodable {
    
    var name:String
    var words: [WebWord]
    
    enum CodingKeys: String, CodingKey {
        case name
        case words
        
    }
    
    required init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.words = try container.decode([WebWord].self, forKey: .words)
    }
}
