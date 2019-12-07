//
//  Webservice.swift
//  Wiki Country
//
//  Created by Ordineat on 04/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//
import Foundation


class Webservice {
    
    func getCountries(url: URL, completion: @escaping ([Country]?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                print(error)
                completion(nil)
                
            } else if let loadedData = data {

                do {
                    let okLoadedData = try JSONDecoder().decode([Country].self, from: loadedData)
                    completion(okLoadedData)
                } catch let error{
                    print(error)
                }

            }
            
        }.resume()
    }
    
}
