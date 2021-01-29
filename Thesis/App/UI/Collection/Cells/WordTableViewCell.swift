//
//  WordCell.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM
import RxSwift

class WordTableViewCell: TableViewCell<WordItemModel> {

    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var engLabel: UILabel!
    @IBOutlet weak var rusLabel: UILabel!
    @IBOutlet weak var checkMarkLeading: NSLayoutConstraint!
    
    let selectedState = PublishSubject<Bool>()
    
    override func bind(viewModel: TableViewCell<WordItemModel>.ViewModel) {
        viewModel.rus.bind(to: rusLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.eng.bind(to: engLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.isEdited.bind {[weak self] (bool) in
            self?.checkMarkLeading.constant = bool ? 16 : -30
            self?.checkMarkImageView.isHidden = !bool
        }.disposed(by: reusableDisposeBag)
        selectedState.bind(to: viewModel.isSelected).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkMarkImageView.image = selected ? #imageLiteral(resourceName: "CheckBox") : #imageLiteral(resourceName: "CheckBoxOutline")
        selectedState.onNext(selected)
    }
    
}
