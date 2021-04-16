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
    @IBOutlet weak var frameView: View!
    @IBOutlet weak var translateLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    fileprivate let animationQueue = DispatchQueue(label: "SwitchViewAnimationQueue", qos: .userInteractive, attributes: .concurrent, target: DispatchQueue.main)
    
    @IBInspectable var wordText: String = "" { didSet { self.setNeedsLayout() } }
    @IBInspectable var transcriptionText: String = "" { didSet { self.setNeedsLayout() } }
    @IBInspectable var translateText: String = "" { didSet { self.setNeedsLayout() } }
    
    let currentWord = BehaviorRelay<Word?>(value: nil)
    let fail = PublishSubject<Void>()
    let complete = PublishSubject<Void>()
    
    lazy var labelsEnabled = Set<ViewLabel>()
    
    
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
        self.animationQueue.async(flags: .barrier) {[self] in
            self.wordLabel.isHidden = self.wordText.isEmpty || !self.labelsEnabled.contains(.word)
            self.transcriptionLabel.isHidden = self.transcriptionText.isEmpty || !self.labelsEnabled.contains(.trascrition)
            self.translateLabel.isHidden = self.translateText.isEmpty || !self.labelsEnabled.contains(.translate)

            self.wordLabel.text = self.wordText
            self.transcriptionLabel.text = self.transcriptionText
            self.translateLabel.text = self.translateText
        }

    }
    
    
    fileprivate func changeWord(_ newWord: Word){
            
        self.animationQueue.async { [self] in
            UIView.transition(with: self, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                self.wordText = newWord.word
                self.translateText = newWord.transcription
                self.translateText = newWord.translate
                self.frameView.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self.frameView.borderWidth = 1.0
            })
        }
    }
    
    private func completeAction(){
        animationQueue.async { [self] in
            UIView.animate(withDuration: 0.2,delay: 0.0, options: [.curveLinear], animations: {
                self.frameView.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 0.6995933219)
                self.frameView.borderWidth = 6.0
            })
        }
    }
    
    private func failAction(){
        animationQueue.async { [self] in
            UIView.animate(withDuration: 0.2,delay: 0.0, options: [.curveLinear], animations: {
                self.transform = CGAffineTransform(a: 1, b: 0, c: 0.1, d: 1, tx: 0, ty: 0)
                self.frameView.borderColor = #colorLiteral(red: 0.7823144499, green: 0.1568627506, blue: 0.07450980693, alpha: 0.808406464)
                self.frameView.borderWidth = 6.0
            }, completion:{ (end) in
                UIView.animate(withDuration: 0.2,delay: 0.0, options: [.curveLinear], animations: {
                    self.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
                })
            })
        }
    }
    
    
}


extension Reactive where Base: SwitchView {
    
    var word: Binder<Word> {
        return Binder<Word>(base.self, binding: { view, newWord in
            view.animationQueue.asyncAfter(deadline: .now() + .milliseconds(10)) {
                view.changeWord(newWord)
            }
        })
    }
    
    
}

extension SwitchView {
    
    enum ViewLabel {
        case word
        case translate
        case trascrition
    }
    
    enum ViewAnimation {
        case fail
        case complete
        case transition
    }
    
}
