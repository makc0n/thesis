//
//  ChoiceTestViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 28.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources
import RxSwift

class ChoiceTestViewController: ViewController<ChoiceTestViewModel>,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    @IBOutlet weak var switchView: SwitchView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias TestSection = SectionModel<String,ChoiceItemModel>
    let dataSource: RxCollectionViewSectionedReloadDataSource<TestSection> = CollectionViewConnector.reloadDataSource(ChoiceCollectionViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switchView.labelsEnabled = [.word]
        CollectionViewConnector.register(ChoiceCollectionViewCell.self, for: collectionView)
    }    
    
    override func bind(viewModel: ViewController<ChoiceTestViewModel>.ViewModel) {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        viewModel.correctAnswer.bind(to: switchView.complete).disposed(by: disposeBag)
        viewModel.uncorrectAnswer.bind(to: switchView.fail).disposed(by: disposeBag)
        
        viewModel.currentWord.unwrap().bind(to: switchView.rx.word).disposed(by: disposeBag)
        
        viewModel.sections.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        collectionView.rx.modelSelected(ChoiceItemModel.self).bind(to: viewModel.cellSelected).disposed(by: disposeBag)
        
        super.bind(viewModel: viewModel)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = self.dataSource.sectionModels[indexPath.section].items[indexPath.row]
        
        let size = NSAttributedString(string: cell.word.translate, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: .greatestFiniteMagnitude), options: .truncatesLastVisibleLine, context: nil).size
//        let width = (self.collectionView.frame.width - 30) / 2
        return CGSize(width: size.width * 1.5 + 16, height: 58 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath){
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChoiceCollectionViewCell else {
            return
        }        
        cell.frameView.backgroundColor = #colorLiteral(red: 0.12871629, green: 0.4663972259, blue: 1, alpha: 0.6955265411)
        
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChoiceCollectionViewCell else {
            return
        }
        cell.frameView.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.862745098, blue: 1, alpha: 1)
    }
    
    
}
