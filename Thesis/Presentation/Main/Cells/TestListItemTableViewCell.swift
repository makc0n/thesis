//
//  TestListItemTableViewCell.swift
//  Thesis
//
//  Created by Максим Василаки on 05.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM

class TestListItemTableViewCell: TableViewCell<TestListItemViewModel> {
    
    
    @IBOutlet weak var frameView: View!
    @IBOutlet weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state    
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
    }
    
    override func bind(viewModel: TestListItemViewModel) {
        
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
}
