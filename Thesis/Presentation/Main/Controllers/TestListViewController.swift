//
//  TestListViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM
import RxDataSources

class TestListViewController: ViewController<TestListViewModel>{
    
   
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, TestListItemViewModel>> = TableViewConnector.reloadTableViewDataSource(TestListItemTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        TableViewConnector.register(TestListItemTableViewCell.self, for: tableView)
    }
    
    
    override func bind(viewModel: TestListViewModel) {
        
        viewModel.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}

