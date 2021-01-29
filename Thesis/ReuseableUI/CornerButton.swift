//
//  CustomButtom.swift
//  Thesis
//
//  Created by Максим Василаки on 20.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit
@IBDesignable
class CornerButton: UIButton{
    
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {didSet { self.layer.cornerRadius = cornerRadius  }}
    @IBInspectable var borderWidth: CGFloat = 0 {didSet {self.layer.borderWidth = borderWidth}}
    @IBInspectable var borderAlpha: CGFloat = 1.0 {didSet {self.layer.borderColor = self.layer.borderColor?.copy(alpha: borderAlpha/25.0)}}
    @IBInspectable var borderColor: UIColor = .clear { didSet { self.layer.borderColor = borderColor.cgColor } }

    
}
