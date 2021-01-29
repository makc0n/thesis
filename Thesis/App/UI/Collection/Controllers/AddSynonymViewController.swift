//
//  AddSynonymViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources

class AddSynonymViewController: ViewController<AddSynonymViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeBarButtonItem: UIBarButtonItem!
    
    typealias WordSection = SectionModel<String, WordItemModel>
    lazy var dataSource: RxTableViewSectionedReloadDataSource<WordSection> = TableViewConnector.reloadTableViewDataSource(WordTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(WordTableViewCell.self, for: tableView)
    }
    
    override func bind(viewModel: ViewController<AddSynonymViewModel>.ViewModel) {
        
        viewModel.wordsItemsSections.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        viewModel.allowSelection.bind {[weak self](allow) in
            self?.tableView.allowsMultipleSelection = allow
        }.disposed(by: disposeBag)
        
        tableView.rx.longPressGesture().when(.began).map({_ in}).bind(to: viewModel.changeSelection).disposed(by: disposeBag)
        
        completeBarButtonItem.rx.tap.bind(to: viewModel.complete).disposed(by: disposeBag)
        super.bind(viewModel: viewModel)
    }
}
