//
//  TestViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift

class SimpleInputTestViewController: ViewController<SimpleInputTestViewModel>, UITextFieldDelegate{
    
    @IBOutlet weak var textField: TextField!
    @IBOutlet weak var completeButton: CornerButton!
    @IBOutlet weak var switchView: SwitchView!
    
    override func bind(viewModel: SimpleInputTestViewModel) {
        
        completeButton.rx.tap.map{[unowned self]_ in return self.textField.text! }.bind(to: viewModel.answerText).disposed(by: disposeBag)
        viewModel.currentWord.unwrap().bind(to: switchView.rx.word).disposed(by: disposeBag)
        viewModel.uncorrectAnswer.bind(to: switchView.fail).disposed(by: disposeBag)
        viewModel.correctAnswer.bind(to: switchView.complete).disposed(by: disposeBag)
        viewModel.correctAnswer.bind(onNext: {[weak self]_ in self?.textField.text = "" }).disposed(by: disposeBag)
        
                
        super.bind(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.becomeFirstResponder()
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        viewModel.answerText.onNext(textField.text ?? "")
        
        return true
    }
    
}
