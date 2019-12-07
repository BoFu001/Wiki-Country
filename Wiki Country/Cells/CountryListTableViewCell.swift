//
//  CountryListTableViewCell.swift
//  Wiki Country
//
//  Created by Ordineat on 05/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//

import UIKit

class CountryListTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    
    func configure(_ cm: Country) {
        self.nameLabel.text = cm.name
        self.regionLabel.text =  cm.region
        self.flagImageView.setFlag(url: "https://www.countryflags.io/\(cm.alpha2Code)/flat/64.png")
    }

}
