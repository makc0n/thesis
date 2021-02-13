//
//  SwitchView.swift
//  Thesis
//
//  Created by Максим Василаки on 20.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

@IBDesignable
class SwitchView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet weak var transcriptionLabel: UILabel!
    @IBOutlet weak var frameView: CustomView!
    @IBOutlet weak var translateLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    let fail = PublishSubject<Void>()
    let complete = PublishSubject<Void>()
    private let semaphore = DispatchSemaphore(value: 1)
    
    @IBInspectable var wordText: String = "" { didSet { layoutSubviews() } }
    @IBInspectable var transcriptionText: String = "" { didSet { layoutSubviews() } }
    @IBInspectable var translateText: String = "" { didSet { layoutSubviews() } }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    
    private func loadUI(){
        Bundle.main.loadNibNamed("SwitchView", owner: self, options: nil)
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        addSubview(view)
        
        fail.bind(onNext: failAction).disposed(by: disposeBag)
        complete.bind(onNext: completeAction).disposed(by: disposeBag)        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        wordLabel.isHidden = wordText.isEmpty
        transcriptionLabel.isHidden = transcriptionText.isEmpty
        translateLabel.isHidden = translateText.isEmpty
        
        wordLabel.text = wordText
        transcriptionLabel.text = transcriptionText
        translateLabel.text = translateText
        
    }
    
    
    fileprivate func changeWord(_ newWord: Word){
        
        DispatchQueue.main.async {
            self.semaphore.signal()
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.wordText = newWord.rus
                self.transcriptionLabel.text = newWord.transcription
                self.frameView.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.frameView.borderWidth = 1.0
            }, completion: {[weak self] _ in
                self?.semaphore.wait()
            })
        }
        
        
    }
    
    private func completeAction(){
        DispatchQueue.main.async {
            self.semaphore.signal()
            UIView.animate(withDuration: 0.2,delay: 0.0, options: [.curveLinear], animations: {
                self.frameView.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 0.6995933219)
                self.frameView.borderWidth = 6.0
            }, completion: {[weak self] _ in
                self?.semaphore.wait()
            })
        }
    }
    
    private func failAction(){
        DispatchQueue.main.async {
            self.semaphore.signal()
            UIView.animate(withDuration: 0.1,delay: 0.0, options: [.curveLinear], animations: {
                self.transform = CGAffineTransform(a: 1, b: 0, c: 0.1, d: 1, tx: 0, ty: 0)
                self.frameView.borderColor = #colorLiteral(red: 0.7823144499, green: 0.1568627506, blue: 0.07450980693, alpha: 0.808406464)
                self.frameView.borderWidth = 6.0
            }, completion:{[weak self] (end) in
                UIView.animate(withDuration: 0.1,delay: 0.0, options: [.curveLinear], animations: {
                    self?.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
                },completion: { _ in self?.semaphore.wait()})
            })
        }
    }
    
    enum State {
        case rus
        case eng
        case all
    }
    
}


extension Reactive where Base: SwitchView {
    
    var word: Binder<Word> {
        return Binder<Word>(base.self, binding: { view, newWord in
            view.changeWord(newWord)
        })
    }
    
    
}
