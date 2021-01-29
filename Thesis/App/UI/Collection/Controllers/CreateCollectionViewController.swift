//
//  CreateCollectionViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources

class CreateCollectionViewController: ViewController<CreateEditCollectionViewModel> {
    @IBOutlet weak var nameLabel: TextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var addWordButton: CornerButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeBarButtonItem: UIBarButtonItem!
    
    typealias WordsSection = SectionModel<String,WordItemModel>
    let dataSource:RxTableViewSectionedReloadDataSource<WordsSection>  = TableViewConnector.reloadTableViewDataSource(WordTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(WordTableViewCell.self, for: tableView)
    }
    
    
    override func bind(viewModel: ViewController<CreateEditCollectionViewModel>.ViewModel) {
        
        viewModel.name.distinctUntilChanged().bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        nameLabel.rx.text.bind(to: viewModel.name).disposed(by: disposeBag)
        
        completeBarButtonItem.rx.tap.bind(to: viewModel.complete).disposed(by: disposeBag)
        addWordButton.rx.tap.bind(to: viewModel.addWord).disposed(by: disposeBag)
        
        tableView.rx.longPressGesture().when(.began).bind(onNext: {[unowned self] _ in
        self.tableView.isEditing = !self.tableView.isEditing
        }).disposed(by: disposeBag)
        
        tableView.rx.modelDeleted(WordItemModel.self).bind(to: viewModel.modelDeleted).disposed(by: disposeBag)
        dataSource.canEditRowAtIndexPath = {_,_ in
            return true
        }
        
        viewModel.wordSectionsItems.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        super.bind(viewModel: viewModel)
    }
    
}
