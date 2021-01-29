//
//  Realms.swift
//  Thesis
//
//  Created by Максим Василаки on 20.08.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RealmSwift

enum Realms {
    
    case collections
    case words
    case user
    
    private var name: String {
        switch self {
        case .collections: return "collection"
        case .words: return "words"
        case .user: return "user"
        }
    }
    
    private var configuration: Realm.Configuration {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.fileURL = configuration.fileURL?.deletingLastPathComponent().appendingPathComponent("\(name).realm")
        return configuration
    }
    
    func create() -> Realm {
        return try! Realm(configuration: configuration)
    }
    
    static func deleteAllRealms() {
        let realmsFolderURL = Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent() 
        
        let realmsFilesExtenstions = ["realm"]
        let realmFilesURLs = try! FileManager.default.contentsOfDirectory(at: realmsFolderURL, includingPropertiesForKeys: nil, options: [])
        
        for realmFileURL in realmFilesURLs {
            if realmsFilesExtenstions.contains(realmFileURL.pathExtension) {
                let realm = try! Realm(fileURL: realmFileURL)
                try! realm.write {
                    realm.deleteAll()
                }
            }
        }
    }
}
