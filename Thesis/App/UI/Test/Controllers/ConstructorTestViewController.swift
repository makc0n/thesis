//
//  ConstructorTestViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 29.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxSwift
import RxDataSources

class ConstructorTestViewController : ViewController<ConstructorTestViewModel>,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    @IBOutlet weak var switchView: SwitchView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias TestSection = SectionModel<String,ConstructorItemModel>
    let dataSource: RxCollectionViewSectionedReloadDataSource<TestSection> = CollectionViewConnector.reloadDataSource(ConstructorCollectionViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionViewConnector.register(ConstructorCollectionViewCell.self, for: collectionView)
    }
    
    override func bind(viewModel: ViewController<ConstructorTestViewModel>.ViewModel) {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.currentWord.unwrap().bind(to: switchView.rx.word).disposed(by: disposeBag)
        viewModel.correctAnswer.bind(to: switchView.complete).disposed(by: disposeBag)
        viewModel.uncorrectAnswer.bind(to: switchView.fail).disposed(by: disposeBag)
        viewModel.sections.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        viewModel.answer.map({$0.isEmpty ? "Соберите слово": $0}).bind(to: answerLabel.rx.text).disposed(by: disposeBag)
        collectionView.rx.modelSelected(ConstructorItemModel.self).bind(to: viewModel.cellSelected).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    
    
    
}
