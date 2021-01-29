//
//  ChoiceCollectionViewCell.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM

class ChoiceCollectionViewCell: CollectionViewCell<ChoiceItemModel> {

    @IBOutlet weak var titleLabel: UILabel!    
    @IBOutlet weak var contentCellView: UIView!
    @IBOutlet weak var frameView: CustomView!
    
    override func bind(viewModel: ChoiceItemModel) {
//        viewModel.wordEng.bind(to: titleLabel.rx.text).disposed(by: reusableDisposeBag)
        frameView.backgroundColor = .white
        super.bind(viewModel: viewModel)
    }
    
    
    

}
