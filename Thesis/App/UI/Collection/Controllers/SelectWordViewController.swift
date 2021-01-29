//
//  SelectWordViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 31.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources

class SelectWordViewController: ViewController<SelectWordViewModel> {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var completeBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    typealias WordSection = SectionModel<String, WordItemModel>
    let dataSource: RxTableViewSectionedReloadDataSource<WordSection> = TableViewConnector.reloadTableViewDataSource(WordTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(WordTableViewCell.self, for: tableView)
    }
    
    override func bind(viewModel: ViewController<SelectWordViewModel>.ViewModel) {
        viewModel.sections.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.longPressGesture().when(.began).map({_ in}).bind(to: viewModel.changeSelection).disposed(by: disposeBag)
        viewModel.allowSelection.bind {[weak self](allow) in
            self?.tableView.allowsSelection = allow
            self?.tableView.allowsMultipleSelection = allow
        }.disposed(by: disposeBag)
        addBarButtonItem.rx.tap.bind(to: viewModel.add).disposed(by: disposeBag)
        completeBarButtonItem.rx.tap.bind(to: viewModel.complete).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
