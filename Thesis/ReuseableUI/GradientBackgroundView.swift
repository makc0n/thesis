//
//  GradientBackgroundView.swift
//  Thesis
//
//  Created by Максим Василаки on 10.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit

class GradientBackgroundView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    private func loadUI() {
        
        self.gradientLayer.colors = [UIColor(named: "topGradientColor")!.cgColor, UIColor(named: "bottomGradientColor")!.cgColor]
        self.gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        self.gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.gradientLayer.locations = [0.8,0.9]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.gradientLayer.frame = self.bounds
        
        self.backgroundColor = .clear
        
    }
    
    
}
