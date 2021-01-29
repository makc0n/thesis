//
//  StatisticViewController.swift
//  Thesis
//
//  Created by Максим Василаки on 17.02.2020.
//  Copyright © 2020 Максим Василаки. All rights reserved.
//

import Foundation
import RxMVVM
import RxDataSources

class StatisticViewController : ViewController<StatisticViewModel>{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func bind(viewModel: StatisticViewModel) {
        
        
        
        super.bind(viewModel: viewModel)
    }
}

/*
 **
 количество слов
 количество изченных
 самое популярное
 количество правильных популярного слова
 количество непривильных ответоа популярного слова
 **
 выбор/конструктор/ручнойВвод тест
 кол учных и неучачных попыток
 кол удачных и неудачных исправлений
 **
 
 
*/
