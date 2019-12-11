//
//  CountryListTableViewCell.swift
//  Wiki Country
//
//  Created by BoFu on 05/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    func configure(_ cm: Country, _ index: Int) {
        self.flagImageView.image = UIImage(named: "earth")
        self.tag = index
        self.nameLabel.text = cm.name
        self.regionLabel.text =  cm.region
        DispatchQueue.main.async {
            if self.tag == index {
                self.flagImageView.setFlag(url: String(format: Constants.COUNTRY_FLAG_URL, "\(cm.alpha2Code)"))
            }
        }
    }

}
