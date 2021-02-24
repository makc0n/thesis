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
    @IBOutlet weak var countView: CustomView!
    @IBOutlet weak var countLabel: UILabel!
    
    override func bind(viewModel: ConstructorItemModel) {
        viewModel.letter.map({String($0)}).bind(to: letterLabel.rx.text).disposed(by: reusableDisposeBag)
        
        viewModel.failSelect.bind(onNext: {[weak self] _ in            
            self?.failAnimation()
        }).disposed(by: reusableDisposeBag)
        
        viewModel.count.bind { [weak self] count in
            self?.isUserInteractionEnabled = count != 0
            self?.isHidden = count == 0
            self?.countView.isHidden = count < 2
            self?.countLabel.text = "\(count)"
        }.disposed(by: reusableDisposeBag)
        
        frameView.backgroundColor = .white
        
        super.bind(viewModel: viewModel)
    }
    
    private func failAnimation() {
        UIView.animate(withDuration: 0.2,delay: 0.0, options: [.autoreverse, .allowUserInteraction], animations:{
            self.frameView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0.5)
        }, completion: {_ in
            self.frameView.backgroundColor = .white
        })
    }
    
    
    
    

}
