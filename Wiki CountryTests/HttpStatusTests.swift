//
//  HttpStatusTests.swift
//  Wiki CountryTests
//
//  Created by BoFu on 07/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import XCTest
@testable import Wiki_Country

class HttpStatusTests: XCTestCase {

    func testHttpStatusCode200() {
        
        let promise = expectation(description: "Status code: 200")
        
        if let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    XCTFail("Error: \(error.localizedDescription)")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        promise.fulfill()
                    } else {
                        XCTFail("Status code: \(httpResponse.statusCode)")
                    }
                    
                }
            }.resume()

        }
        
        wait(for: [promise], timeout: 5)
    }
    
}
