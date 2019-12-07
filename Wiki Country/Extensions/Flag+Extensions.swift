//
//  Flag+Extensions.swift
//  Wiki Country
//
//  Created by Ordineat on 06/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//

import UIKit

extension UIImageView {
    func setFlag(url :String) {
       URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}
