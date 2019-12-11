//
//  Flag+Extensions.swift
//  Wiki Country
//
//  Created by BoFu on 06/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func setFlag(url: String) {

        if let cacheImage = UIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = cacheImage

        } else {

            URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in

                if let error = error {
                    print(error)
                } else if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    UIImageView.imageCache.setObject(image, forKey: url as AnyObject)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
    
    
}


