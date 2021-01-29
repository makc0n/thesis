//
//  CreateWordViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import CleanSDK

class CreateEditWordViewController: ViewController<CreateEditWordViewModel> {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var engTextField: UITextField!
    @IBOutlet weak var rusTextField: UITextField!
    @IBOutlet weak var transcriptionField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: CornerButton!
    
    let dataSource = DataSourceCreator.reloadTableViewDataSource(WordViewCell.self)
    
    override func bind(viewModel: ViewController<CreateEditWordViewModel>.ViewModel) {
        
        saveButton.rx.tap.bind(to: viewModel.saveWord).disposed(by: disposeBag)
        addButton.rx.tap.bind(to: viewModel.addSynonym).disposed(by: disposeBag)
        
        engTextField.rx.controlEvent(.editingDidEnd).map({[weak self] _ in self?.engTextField.text ?? ""}).bind(to: viewModel.eng).disposed(by: disposeBag)
        rusTextField.rx.controlEvent(.editingDidEnd).map({[weak self] _ in self?.rusTextField.text ?? ""}).bind(to: viewModel.rus).disposed(by: disposeBag)
        transcriptionField.rx.controlEvent(.editingDidEnd).map({[weak self] _ in self?.transcriptionField.text ?? ""}).bind(to: viewModel.transcription).disposed(by: disposeBag)
        
        viewModel.word.unwrap().bind(onNext:{[weak self] word in
            self?.engTextField.text = word.eng
            self?.rusTextField.text = word.rus
            self?.transcriptionField.text = word.transcription
            self?.navigationItem.title = "Редактированние"
            }).disposed(by: disposeBag)
        
        viewModel.sections.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
