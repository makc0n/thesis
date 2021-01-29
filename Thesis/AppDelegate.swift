//
//  AppDelegate.swift
//  Thesis
//
//  Created by Максим Василаки on 14.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM
import RealmSwift
import CleanMapper
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let disposeBag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Navigator.set(window: &window, route: NavigationRoutes.main)
        MapperConfiguration.configure()
        
        #if DEBUG
        UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #endif
        
        
        
//        do{
//            try loadDatabase()
//        } catch{
//            print(error)
//        }

        return true
    }
    
    private func loadDatabase() throws{
        
        Realms.deleteAllRealms()
        
        let bundle = Bundle.main.path(forResource: "noun100", ofType: "json")
        let url = URL(fileURLWithPath: bundle!)
        let data = try Data(contentsOf: url)
        
        if let webCollection = try? JSONDecoder().decode(WebCollection.self, from: data){
            let collection: Collection = Mapper.map(webCollection)
            let words: [Word] = webCollection.words.map({Mapper.map($0)})
            
            AddCollection.default.use(input: .init(collection: collection)).subscribe().disposed(by: disposeBag)
            AddWordsToCollection.default.use(input: .init(collectionID: collection.id, wordsIDs: words.map({$0.id})) ).subscribe().disposed(by: disposeBag)
            AddWords.default.use(input: .init(words: words)).subscribe().disposed(by: disposeBag)
        }
        
        
        
    }



}


