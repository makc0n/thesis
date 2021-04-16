//
//  CollectionListTableViewCell.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM
class CollectionListTableViewCell: TableViewCell<CollectionListItemModel> {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var widthOfProgressLabel: NSLayoutConstraint!
    @IBOutlet weak var customView: View!
    
    override func bind(viewModel: CollectionListItemModel) {
        
        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.progressString.bind(to: progressLabel.rx.text).disposed(by: reusableDisposeBag)
        
        
        self.selectionStyle = .none
        super.bind(viewModel: viewModel)
    }
  
    
    
}
