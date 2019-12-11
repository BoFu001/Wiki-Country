//
//  CountryListViewModel.swift
//  Wiki Country
//
//  Created by BoFu on 04/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import Foundation

struct CountryListViewModel {
    
    private let countries: [Country]
    private var filteredCountries: [Country]
    
    init(_ countries: [Country]){
        self.countries = countries
        self.filteredCountries = countries
    }
}

extension CountryListViewModel {

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.filteredCountries.count
    }
    
    func countryAtIndex(_ index: Int) -> Country {
        let country = self.filteredCountries[index]
        return country
    }

    mutating func filterCountry(_ key: String, completion: (Int) -> () ) {
        if key != "" {
            self.filteredCountries = self.countries.filter{ $0.region == key }
            completion(self.filteredCountries.count)
        } else {
            self.filteredCountries = self.countries
            completion(self.filteredCountries.count)
        }
    }
}
