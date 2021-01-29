//
//  PreTestViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class PreTestViewController: ViewController<PreTestViewModel> {
    
    @IBOutlet weak var answerLabel: UILabel!    
    @IBOutlet weak var nextButton: CornerButton!
    @IBOutlet weak var allreadyButton: CornerButton!
    @IBOutlet weak var switchView: SwitchView!
    
    override func bind(viewModel: PreTestViewModel) {
        
        viewModel.currentWord.unwrap().bind(to: switchView.rx.word).disposed(by: disposeBag)
        viewModel.currentWord.unwrap().map({$0.rus}).bind(to: answerLabel.rx.text).disposed(by: disposeBag)
        
        nextButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: viewModel.acceptWord).disposed(by: disposeBag)
        
        allreadyButton.rx.tap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .bind(to: viewModel.nextWord).disposed(by: disposeBag)
        
        
        super.bind(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    
}
