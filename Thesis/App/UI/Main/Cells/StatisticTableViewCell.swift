//
//  StatisticTableViewCell.swift
//  Thesis
//
//  Created by Максим Василаки on 03.05.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM

class StatisticTableViewCell: TableViewCell<StatisticItemModel> {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func bind(viewModel: TableViewCell<StatisticItemModel>.ViewModel) {
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.value.bind(to: valueLabel.rx.text).disposed(by: reusableDisposeBag)
        super.bind(viewModel: viewModel)
    }
    
  
    
}
