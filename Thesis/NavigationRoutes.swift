//
//  NavigationRoutes.swift
//  Thesis
//
//  Created by Максим Василаки on 21.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa

enum NavigationRoutes: NavigationRouteType {
    
    case goBack
    case closeModal
    case changeTab(tabIndex: Int)
    
//MARK: - case Main
    case main
    case testList
    case collectionList
    case statisticList
    
//MARK: - case PreTest
    case pushPreTest(usedWordsIDs: [String], testConfiguration: TestConfiguration)
    case replacePreTest(usedWordsIDs: [String], testConfiguration: TestConfiguration)
    
//MARK: - case ChoiceTest
    case pushChoiceTest(words: [Word], testConfiguration: TestConfiguration)
    case replaceChoiceTest(words: [Word], testConfiguration: TestConfiguration)
    
//MARK: - case Constructor
    case pushConstructor(words: [Word], testConfiguration: TestConfiguration)
    case replaceConstructor(words: [Word], testConfiguration: TestConfiguration)
    
//MARK: - case SimpleInput
    case pushSimpleInput(words: [Word], testConfiguration: TestConfiguration)
    case replaceSimpleInput(words: [Word], testConfiguration: TestConfiguration)
    
//MARK: - case EndTest
    case replaceEndTest

//MARK: - case Creating and Editing
    case collection(collection: Collection)
    case createCollection
    case editCollection(collection: Collection)
    case createWord
    case editWord(word: Word)
    case addWordToCollection(collectionID: String)
    case selectWords(wordsIDs: BehaviorRelay<[String]>)
    case addSynonyms(wordID: String, synonymsIDs: BehaviorRelay<[String]>)
    
    struct Storyboard {
        static let main = "Main"
        static let test = "Test"
        static let collection = "Collection"
    }
    
    
    
    
    var navigationAction: NavigationAction{
        switch self {
        case .goBack:
            return NavigationAction.create(navigationType: .pop)
        case .closeModal:
            return NavigationAction.create(navigationType: .dismiss)
        case let .changeTab(tabIndex):
            return NavigationAction.create(navigationType: .changeTab(tabIndex))
//MARK: - Main
            
        case .main:
            return NavigationAction.create(navigationType:.root){
                self.instantiateController("MainTabBarController", storyboardName: Storyboard.main)
            }
        case .testList:
            return NavigationAction.create(navigationType: .undefined){
                self.instantiateController(TestListViewController.self, storyboardName: Storyboard.main, viewModel: TestListViewModel())
            }
        case .collectionList:
            return NavigationAction.create(navigationType: .undefined){
                self.instantiateController(CollectionListViewController.self, storyboardName: Storyboard.main, viewModel: CollectionListViewModel())
            }
        case .statisticList:
            return NavigationAction.create(navigationType: .undefined){
                self.instantiateController(StatisticViewController.self, storyboardName: Storyboard.main, viewModel: StatisticViewModel())
            }
//MARK: - PreTest
            
        case let .pushPreTest(usedWordsIDs, testConfiguration):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(PreTestViewController.self, storyboardName: Storyboard.test, viewModel: PreTestViewModel(usedWordsIDs: usedWordsIDs, testConfiguration: testConfiguration))
            }
        case let .replacePreTest(usedWordsIDs, testConfiguration):
            return NavigationAction.create(navigationType: .pushAndReplace){
                self.instantiateController(PreTestViewController.self, storyboardName: Storyboard.test, viewModel: PreTestViewModel(usedWordsIDs: usedWordsIDs, testConfiguration: testConfiguration))
            }
//MARK: - ChoiceTest
        
        case let .pushChoiceTest(words, testConfiguration):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(ChoiceTestViewController.self, storyboardName: Storyboard.test, viewModel: ChoiceTestViewModel(words: words, testConfiguration: testConfiguration) )
            }
        case let .replaceChoiceTest(words, testConfiguration):
            return NavigationAction.create(navigationType: .pushAndReplace){
                self.instantiateController(ChoiceTestViewController.self, storyboardName: Storyboard.test, viewModel: ChoiceTestViewModel(words: words, testConfiguration: testConfiguration))
            }
//MARK: - Constructor
            
        case let .pushConstructor(words, testConfiguration):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(ConstructorTestViewController.self, storyboardName: Storyboard.test, viewModel: ConstructorTestViewModel(words: words, testConfiguration: testConfiguration))
            }
        case let .replaceConstructor(words, testConfiguration):
            return NavigationAction.create(navigationType: .pushAndReplace){
                self.instantiateController(ConstructorTestViewController.self, storyboardName: Storyboard.test, viewModel: ConstructorTestViewModel(words: words, testConfiguration: testConfiguration))
            }
//MARK: - SimpleInput
        
        case let .pushSimpleInput(words, testConfiguration):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(SimpleInputTestViewController.self, storyboardName: Storyboard.test, viewModel: SimpleInputTestViewModel(words: words, testConfiguration: testConfiguration))
            }
        case let .replaceSimpleInput(words, testConfiguration):
            return NavigationAction.create(navigationType: .pushAndReplace){
                self.instantiateController(SimpleInputTestViewController.self, storyboardName: Storyboard.test, viewModel: SimpleInputTestViewModel(words: words, testConfiguration: testConfiguration))
            }
//MARK: - EndTest
            
        case .replaceEndTest:
            return NavigationAction.create(navigationType: .pushAndReplace){
                self.instantiateController(EndTestViewController.self, storyboardName: Storyboard.test, viewModel: EndTestViewModel())
            }
            
//MARK: - Creating and Editing
            
        case let .collection(collection):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CollectionViewController.self, storyboardName: Storyboard.collection, viewModel: CollectionViewModel(collection))
            }
            
        case .createCollection:
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CreateCollectionViewController.self, storyboardName: Storyboard.collection, viewModel: CreateEditCollectionViewModel() )
            }
        case let .editCollection(collectionID):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CreateCollectionViewController.self, storyboardName: Storyboard.collection, viewModel: CreateEditCollectionViewModel(editCollection: collectionID))
            }
        case .createWord:
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CreateEditWordViewController.self, storyboardName: Storyboard.collection, viewModel: CreateEditWordViewModel())
            }
        case let .editWord(word):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CreateEditWordViewController.self, storyboardName: Storyboard.collection, viewModel: CreateEditWordViewModel(editWord: word))
            }
            
        case let .addWordToCollection(collectionID):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(CreateEditWordViewController.self, storyboardName: Storyboard.collection, viewModel: CreateEditWordViewModel(addWordToCollection: collectionID) )
            }
            
        case let .selectWords(wordsIDs):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(SelectWordViewController.self, storyboardName: Storyboard.collection, viewModel: SelectWordViewModel(wordsIDs))
            }
        case let .addSynonyms(wordID,synonymsIDs):
            return NavigationAction.create(navigationType: .push){
                self.instantiateController(AddSynonymViewController.self, storyboardName: Storyboard.collection, viewModel: AddSynonymViewModel(wordID: wordID, synonymsIDs: synonymsIDs) )
            }
            
            
            
            
        }
    }
    
}
