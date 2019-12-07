//
//  CountryDetailViewController.swift
//  Wiki Country
//
//  Created by Ordineat on 05/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    var countryModel: Country?
    var flagImage: UIImage?
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var subregionLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
    }
    
    private func setupData() {
        self.flagImageView.image = flagImage
        self.nameLabel.text = countryModel?.name
        self.capitalLabel.text = countryModel?.capital
        self.regionLabel.text = countryModel?.region
        self.subregionLabel.text = countryModel?.subregion
        self.populationLabel.text = countryModel?.population.formatAsPopulation
        self.languageLabel.text = format(countryModel?.languages)
    }
}



extension CountryDetailViewController {
    func format(_ languages: [Language]?) -> String {
        if let languages = languages {
            var str = ""
            for i in 0..<languages.count {
                str += languages[i].name
                if i < languages.count - 1 {
                    str += ", "
                }
            }
            return str
        } else {
            return ""
        }
    }
}
