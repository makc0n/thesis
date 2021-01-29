//
//  CollectionViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 19.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxCocoa
import RxDataSources
import RxSwift
import RxGesture

class CollectionViewController:  ViewController<CollectionViewModel> {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    typealias CollectionSection = SectionModel<String, WordItemModel>
    lazy var dataSource: RxTableViewSectionedReloadDataSource<CollectionSection> = TableViewConnector.reloadTableViewDataSource(WordTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(WordTableViewCell.self, for: tableView)
    }
    
    override func bind(viewModel: CollectionViewModel) {
        
        dataSource.canEditRowAtIndexPath = {_,_ in
            return true
        }
        
        viewModel.wordSectionsItems.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.allowsMultipleSelection.bind {[unowned self] (allow) in
            self.tableView.allowsMultipleSelection = allow
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(WordItemModel.self).bind(to: viewModel.wordItemSelected).disposed(by: disposeBag)
        tableView.rx.modelDeleted(WordItemModel.self).bind(to: viewModel.wordItemDeleted).disposed(by: disposeBag)
        tableView.rx.longPressGesture().when(.began).map{_ in}.bind(to: viewModel.longPress).disposed(by: disposeBag)
        
        viewModel.longPress.bind(onNext: {
            self.tableView.isEditing = !self.tableView.isEditing
        }).disposed(by: disposeBag)
        
        self.title = viewModel.collection.name
        
        addBarButtonItem.rx.tap.bind(to: viewModel.addWord).disposed(by: disposeBag)
        super.bind(viewModel: viewModel)
    }
}
