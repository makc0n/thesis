//
//  TextField.swift
//  Thesis
//
//  Created by Максим Василаки on 30.03.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


@IBDesignable
class TextField: UITextField {
    private let disposeBag = DisposeBag()
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
            didSet { self.layer.cornerRadius = cornerRadius  }
        }
        
    @IBInspectable var borderWidth: CGFloat = 0 {
            didSet { self.layer.borderWidth = borderWidth
            }
        }
        
    @IBInspectable var firstLineHeadIndent: Int = 0 {
            didSet {
                let spacerView = UIView(frame:CGRect(x:0, y:0, width:firstLineHeadIndent, height:10))
                self.leftViewMode = UITextField.ViewMode.always
                self.leftView = spacerView
            }
        }
    
    lazy var toolbarHeight = self.toolbar.frame.height
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(title: "Готово", style: .done, target: nil, action: nil)
        doneButton.rx.tap.bind(onNext: { [unowned self] in            
            self.endEditing(true)
        }).disposed(by: disposeBag)
        return doneButton
    }()

    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            doneButton
        ], animated: false)
        toolbar.sizeToFit()
        return toolbar
    }()
    
       
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    private func loadUI() {
        inputAccessoryView = toolbar
    }
    
    
    
 
}

extension Reactive where Base: TextField {
    
    var endEdit: Observable<String?> {
        return base.rx.controlEvent(.editingDidEnd).map({base.text})
    }
    
    var changeText: Binder<String?> {
        return Binder<String?>(base.self, binding: { textField, newText in
            if textField.text != newText {
                textField.text = newText
            }
        })
    }
    
}

