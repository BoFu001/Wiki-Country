//
//  FilterViewModelTests.swift
//  Wiki CountryTests
//
//  Created by BoFu on 10/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import XCTest
@testable import Wiki_Country

class FilterViewModelTests: XCTestCase {

    var filterViewModel: FilterViewModel!
    let userDefaults = UserDefaults.standard
    
    override func setUp() {
        self.filterViewModel = FilterViewModel()
        userDefaults.removeObject(forKey: "filter")
    }

    override func tearDown() {
        super.tearDown()
        userDefaults.removeObject(forKey: "filter")
    }

    func testselectFilter() {
        self.filterViewModel.selectedFilter = Filter.allCases[0]
        XCTAssertNotNil(userDefaults.value(forKey: "filter"))
    }

}
