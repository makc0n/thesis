//
//  View.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit

@IBDesignable
class View: UIView {
    
    @IBInspectable var viewColor: UIColor = .clear { didSet{ setNeedsLayout() } }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 { didSet{ setNeedsLayout() } }
    @IBInspectable var borderColor: UIColor? = nil { didSet{ setNeedsLayout() } }
    
    private var rectCorners: UIRectCorner = UIRectCorner() { didSet{ setNeedsLayout() } }
    @IBInspectable var cornerRadius: CGFloat = 0.0 { didSet{ setNeedsLayout() } }
    @IBInspectable var topLeft: Bool = true { didSet { _ = topLeft ? rectCorners.insert(.topLeft).memberAfterInsert : rectCorners.remove(.topLeft) } }
    @IBInspectable var topRight: Bool = true { didSet { _ = topRight ? rectCorners.insert(.topRight).memberAfterInsert : rectCorners.remove(.topRight) } }
    @IBInspectable var bottomLeft: Bool = true { didSet { _ = bottomLeft ? rectCorners.insert(.bottomLeft).memberAfterInsert : rectCorners.remove(.bottomLeft) } }
    @IBInspectable var bottomRight: Bool = true { didSet { _ = bottomRight ? rectCorners.insert(.bottomRight).memberAfterInsert : rectCorners.remove(.bottomRight) } }
    
    
    
//    override func draw(_ rect: CGRect) {
//        let cornerRadii = CGSize(width: self.cornerRadius, height: self.cornerRadius)
//        let rectPath = UIBezierPath(roundedRect: rect, byRoundingCorners: self.rectCorners, cornerRadii: cornerRadii)
//        rectPath.lineWidth = self.borderWidth
//
//        self.viewColor.setFill()
//        rectPath.fill()
//
//        if let borderColor = self.borderColor {
//            borderColor.setStroke()
//            rectPath.stroke()
//        }
//
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = viewColor
        self.layer.cornerRadius = self.cornerRadius
        self.layer.maskedCorners = .init(rawValue: rectCorners.rawValue)
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor

    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layoutSubviews()
    }
    
}
