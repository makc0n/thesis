//
//  CreateWordViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxDataSources
import RxBiBinding

class CreateEditWordViewController: ViewController<CreateEditWordViewModel> {
     
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var engTextField: TextField!
    @IBOutlet weak var rusTextField: TextField!
    @IBOutlet weak var transcriptionField: TextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: CornerButton!
    
    typealias WordSection = SectionModel<String, WordItemModel>
    lazy var dataSource: RxTableViewSectionedReloadDataSource<WordSection> = TableViewConnector.reloadTableViewDataSource(WordTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewConnector.register(WordTableViewCell.self, for: tableView)
    }
    
    override func bind(viewModel: ViewController<CreateEditWordViewModel>.ViewModel) {
        
        saveButton.rx.tap.bind(to: viewModel.saveWord).disposed(by: disposeBag)
        addButton.rx.tap.bind(to: viewModel.addSynonym).disposed(by: disposeBag)
        
        engTextField.rx.text.unwrap().filter({!$0.isEmpty}).bind(to: viewModel.eng).disposed(by: disposeBag)
        rusTextField.rx.text.unwrap().filter({!$0.isEmpty}).bind(to: viewModel.rus).disposed(by: disposeBag)
        transcriptionField.rx.text.unwrap().filter({!$0.isEmpty}).bind(to: viewModel.transcription).disposed(by: disposeBag)
        
        viewModel.rus.unwrap().bind(to: rusTextField.rx.changeText).disposed(by: disposeBag)
        viewModel.eng.unwrap().bind(to: engTextField.rx.changeText).disposed(by: disposeBag)
        viewModel.transcription.unwrap().bind(to: transcriptionField.rx.changeText).disposed(by: disposeBag)
                        
        tableView.rx.longPressGesture().when(.began).bind(onNext: {[unowned self] _ in
            self.tableView.isEditing = !self.tableView.isEditing
            }).disposed(by: disposeBag)
        
        
        dataSource.canEditRowAtIndexPath = {_,_ in
            return true
        }
        
        tableView.rx.modelDeleted(WordItemModel.self).bind(to: viewModel.modelDeleted).disposed(by: disposeBag)
        
        
        viewModel.synonymSectionsItems.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
