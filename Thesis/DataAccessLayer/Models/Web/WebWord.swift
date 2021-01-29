//
//  WebWord.swift
//  Thesis
//
//  Created by Максим Василаки on 09.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation

class WebWord: Decodable {
    
    var rus:String
    var eng:String
    var transcription:String
    
    enum CodingKeys: String, CodingKey {
      case rus
      case eng
      case trans
    }
    
    required init(from decoder:Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rus = try container.decode(String.self, forKey: .rus)
        self.eng = try container.decode(String.self, forKey: .eng)
        self.transcription = try container.decode(String.self, forKey: .trans)
        
    }
}
