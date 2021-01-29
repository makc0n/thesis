//
//  customView.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    
    @IBInspectable var cornerRadius:CGFloat = 0.0 {didSet{self.layer.cornerRadius = self.cornerRadius }}
    @IBInspectable var borderWidth:CGFloat = 0.0 {didSet{self.layer.borderWidth = self.borderWidth }}
    @IBInspectable var borderColor:UIColor = .clear {didSet{self.layer.borderColor = self.borderColor.cgColor }}
    
    
}
