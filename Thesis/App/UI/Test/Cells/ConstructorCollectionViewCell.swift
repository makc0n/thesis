//
//  ConstructorCollectionViewCell.swift
//  Thesis
//
//  Created by Максим Василаки on 29.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxMVVM

class ConstructorCollectionViewCell: CollectionViewCell<ConstructorItemModel> {
    @IBOutlet weak var frameView: CustomView!
    @IBOutlet weak var letterLabel: UILabel!
    
    override func bind(viewModel: ConstructorItemModel) {
        viewModel.letter.map({String($0)}).bind(to: letterLabel.rx.text).disposed(by: reusableDisposeBag)
        viewModel.failSelect.bind(onNext: {[weak self] _ in            
            UIView.animate(withDuration: 0.3,delay: 0.0,options: .autoreverse, animations:{
                self?.frameView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0.7608625856)
            }, completion: {_ in
                self?.frameView.backgroundColor = .white
            })
            }).disposed(by: reusableDisposeBag)
        viewModel.hideCell.bind { [weak self](_) in
            self?.isUserInteractionEnabled = false
            self?.isHidden = true
        }.disposed(by: reusableDisposeBag)
        frameView.backgroundColor = .white
        self.isUserInteractionEnabled = true
        self.isHidden = false
        super.bind(viewModel: viewModel)
    }
    
    
    
    

}
