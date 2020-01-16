//
//  ExcusesViewModel.swift
//  the1001excuses
//
//  Created by Alsu Bikkulova on 30/12/2019.
//  Copyright © 2019 Alsu Bikkulova. All rights reserved.
//

import UIKit

class ExcusesViewModel {
    
    let themeTitle: String
    let themeColor: UIColor
    let themeExcuses: [String]

    init(themeTitle: String,
         themeColor: UIColor,
         themeExcuses: [String]) {
        self.themeTitle = themeTitle
        self.themeColor = themeColor
        self.themeExcuses = themeExcuses
    }
}
