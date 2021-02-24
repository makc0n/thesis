//
//  customView.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView, CAAnimationDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setNeedsLayout()
    }

    
    @IBInspectable var cornerRadius: CGFloat = 0.0 { didSet{ setNeedsLayout() } }
    @IBInspectable var borderWidth: CGFloat = 0.0 { didSet{ setNeedsLayout() } }
    @IBInspectable var borderColor: UIColor = .clear { didSet{ setNeedsLayout() } }
    
    private var animations = [CAAnimationGroup]() { didSet { } }
    private let animationIdentife = "CustomViewAnimationQueue"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.cgColor
    }
    
    public func addAnimationGroup(_ animationGroup: CAAnimationGroup) {
        self.animations.append(animationGroup)
        
    }
    
    private func performAnimation() {
        guard let animationGroup = self.animations.first else { return }
        animationGroup.delegate = self
        self.layer.add(animationGroup, forKey: animationIdentife )
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == self.animations.first {
            self.layer.removeAnimation(forKey: animationIdentife)
            _ = self.animations.removeFirst()
        }
    }
    
}
