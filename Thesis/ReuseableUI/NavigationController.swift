//
//  NavigationController.swift
//  Thesis
//
//  Created by Максим Василаки on 10.04.2021.
//  Copyright © 2021 Максим Василаки. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.backgroundColor = .clear
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.prefersLargeTitles = true
        
    }
    
}
