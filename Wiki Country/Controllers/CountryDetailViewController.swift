//
//  CountryDetailViewController.swift
//  Wiki Country
//
//  Created by BoFu on 05/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
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
        self.populationLabel.text = countryModel?.population.toString
        self.languageLabel.text = countryModel?.formattedLanguage
    }
}
