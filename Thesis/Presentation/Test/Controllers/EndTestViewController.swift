//
//  EndTestViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 29.04.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM

class EndTestViewController: ViewController<EndTestViewModel>{
    
    @IBOutlet weak var againButton: CornerButton!
    @IBOutlet weak var doneButton: CornerButton!
    
    
    
    override func bind(viewModel: ViewController<EndTestViewModel>.ViewModel) {
        
        againButton.rx.tap.bind(to: viewModel.againg).disposed(by: disposeBag)
        doneButton.rx.tap.bind(to: viewModel.done).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
}
