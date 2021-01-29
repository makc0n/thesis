//
//  TestListViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM

class TestListViewController: ViewController<TestListViewModel>{
    
    @IBOutlet weak var fastTestButton: UIButton!
    
    override func bind(viewModel: TestListViewModel) {
        
        fastTestButton.rx.tap.bind(to: viewModel.fastTestAction).disposed(by: disposeBag)
        
        
        super.bind(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

