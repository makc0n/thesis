//
//  WordsCollectionViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources

class CollectionListViewController: ViewController<CollectionListViewModel>{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCollectionBarButtonItem: UIBarButtonItem!
    
    typealias CollectionSection = SectionModel<String, CollectionListItemModel>
    let dataSource: RxTableViewSectionedReloadDataSource<CollectionSection> = TableViewConnector.reloadTableViewDataSource(CollectionListTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableViewConnector.register(CollectionListTableViewCell.self, for: tableView)
    }
    
    override func bind(viewModel: CollectionListViewModel) {
        
        dataSource.canEditRowAtIndexPath = { _,_ in
            return true
        }
        
        viewModel.collectionSectionsItems.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.modelSelected(CollectionListItemModel.self).bind(to: viewModel.modelSelected).disposed(by: disposeBag)
        addCollectionBarButtonItem.rx.tap.bind(to: viewModel.addCollection).disposed(by: disposeBag)
        
        
        
        tableView.rx.modelDeleted(CollectionListItemModel.self).bind(to: viewModel.modelDeleted).disposed(by: disposeBag)
        
        tableView.rx.longPressGesture().when(.began).bind(onNext: {[weak self] _ in
            self?.tableView.isEditing = !(self?.tableView.isEditing ?? true)
        }).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
