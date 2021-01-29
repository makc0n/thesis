//
//  CollectionCell.swift
//  Thesis
//
//  Created by Максим Василаки on 20.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import CleanSDK
import Foundation

class WordCollectionViewCell: TableViewCell<CollectionViewCellModel> {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var leadingCheckMark: NSLayoutConstraint!
    
    override func bind(viewModel: CollectionViewCellModel) {
        
        viewModel.word.bind(to: wordLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.translate.bind(to: translateLabel.rx.text).disposed(by: reusableDisposeBag)
//        viewModel.isMultiplicateSelection.bind {[unowned self] (multiplicate) in
//            self.leadingCheckMark.constant = multiplicate ? 8 : -24
//        }.disposed(by: reusableDisposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        checkMarkImageView.image = selected ? #imageLiteral(resourceName: "CheckBox") : #imageLiteral(resourceName: "CheckBoxOutline")
        

        // Configure the view for the selected state
    }
    
}
