//
//  MainViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 14.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxMVVM
import RxGesture

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        
        tabBar.backgroundColor = .clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        
        
        viewControllers = [
            requestController(.testList, tabTitle: "Тест", tabIcon: UIImage(named: "test")),
            requestController(.collectionList, tabTitle: "Наборы", tabIcon: UIImage(named: "collections")),
            requestController(.statisticList, tabTitle: "Статистика", tabIcon: UIImage(named: "statistic"))
        ]
        
        super.viewDidLoad()
    }
    
         
    private func requestController(_ route:NavigationRoutes, tabTitle: String, tabIcon: UIImage?) -> UINavigationController {
        let controller = route.navigationAction.destinationController!
        let navigationController = NavigationController(rootViewController: controller)
        navigationController.tabBarItem = UITabBarItem(title: tabTitle, image: tabIcon ?? UIImage(), tag: 0)
        
        return navigationController
    }

  
    
    
}
