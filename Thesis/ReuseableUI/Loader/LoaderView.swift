//
//  LoaderView.swift
//  PatientDiary
//
//  Created by Artem Eremeev on 14.11.2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    private lazy var blurView: UIVisualEffectView = {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 5
        return blurView
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
        indicator.tintColor = UIColor(red: 0x0F/255, green: 0x73/255, blue: 0x7E/255, alpha: 1)
        return indicator
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
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        addSubview(blurView)
        blurView.addConstraints([
            blurView.widthAnchor.constraint(equalToConstant: 50),
            blurView.heightAnchor.constraint(equalToConstant: 50)
        ])
        addConstraints([
            centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            centerYAnchor.constraint(equalTo: blurView.centerYAnchor),
        ])
        
        addSubview(activityIndicator)
        addConstraints([
            centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor),
            centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor)
        ])
        
    }

}
