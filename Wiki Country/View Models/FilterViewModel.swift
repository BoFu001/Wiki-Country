//
//  FilterViewModel.swift
//  Wiki Country
//
//  Created by Ordineat on 05/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//

import Foundation



struct FilterViewModel {
    let options = Filter.allCases
}

extension FilterViewModel {
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.options.count
    }
    
    func optionAtIndex(_ index: Int) -> Filter {
        let option = self.options[index]
        return option
    }
    
    var selectedFilter: Filter? {
        get {
            if let value = UserDefaults.standard.value(forKey: "filter") as? String {
                return Filter(rawValue: value)
            }
            return nil
        } set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "filter")
        }
    }
}
