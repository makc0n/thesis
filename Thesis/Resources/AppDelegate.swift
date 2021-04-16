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
//            let request = Request(id: 1, completeFast: 0, failFast: 0, completeChoice: 0, failChoice: 0, completeConstructor: 0, failConstructor: 0, completeInput: 0, failInput: 0, completeFirstAttempt: 0, failFirstAttempt: 0, completeCorrectionAttempt: 0, failCorrectionAttempt: 0)
//            let user = User(userName: "user", request: request, countWords: 5, learntWords: 0, countCollection: 0, learntCollection: 0, lastVisitDate: Date(), averagePriority: 1.0, averageScore: 1.0, stepForPriority: 1, totalScore: 0.0)
//            let realmUser: RealmUser = Mapper.map(user)
//            let realm = Realms.user.create()
//            try! realm.write {
//                realm.deleteAll()
//                realm.add(realmUser)
//            }
//        } catch{
//            print(error)
//        }

        return true
    }
    
    private func loadDatabase() throws {
        
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


