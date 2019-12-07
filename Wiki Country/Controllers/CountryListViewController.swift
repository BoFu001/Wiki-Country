//
//  CountryListViewController.swift
//  Wiki Country
//
//  Created by Ordineat on 05/12/2019.
//  Copyright © 2019 Ordineat. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var countryListViewModel: CountryListViewModel?
    
    @IBOutlet weak var noConnectionScreen: UIView!
    
    @IBOutlet weak var retryButton: UIButton!
    @IBAction func retryButton(_ sender: UIButton) {
        getData()
    }
    
    
    @IBOutlet weak var CountryListTable: UITableView!

    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hintYPosition: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
    }
    
    private func getData() {

        if let url = URL(string: "https://restcountries.eu/rest/v2/all") {
            
            Webservice().getCountries(url: url) { countries in
                
                if let countries = countries {
                    self.countryListViewModel = CountryListViewModel(countries)
                    
                    DispatchQueue.main.async {
                        self.CountryListTable.reloadData()
                        self.noConnectionScreen.alpha = 0
                    }
                    
                } else {
                    self.noConnectionScreen.alpha = 1
                }
            }
        }
    }
    
    private func setupUI() {
        hintView.layer.cornerRadius = 5
        retryButton.layer.cornerRadius = 5
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryListViewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryListTableViewCell", for: indexPath) as? CountryListTableViewCell else {
            fatalError("CountryListTableViewCell not found")
        }
        guard let countryModel = self.countryListViewModel?.countryAtIndex(indexPath.row) else {
            fatalError("countryModel not found")
        }
        cell.configure(countryModel)
        
        return cell
    }

    

    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }

    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.backgroundColor = .white
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CountryDetailViewController" {
            
            guard let countryDetailVC = segue.destination as? CountryDetailViewController else {
                fatalError("CountryDetailViewController not found")
            }
            guard let indexPath = self.CountryListTable.indexPathForSelectedRow else {
                fatalError("CountryListTable.indexPathForSelectedRow not found")
            }
            
            let countryModel = self.countryListViewModel?.countryAtIndex(indexPath.row)
            countryDetailVC.countryModel = countryModel
            

            guard let cell = CountryListTable.cellForRow(at: indexPath) as? CountryListTableViewCell else {
                fatalError("CountryListTableViewCell not found")
            }
            countryDetailVC.flagImage = cell.flagImageView.image
        }
        
        
        if segue.identifier == "FilterViewController" {
            
            guard let filterVC = segue.destination as? FilterViewController else {
                fatalError("FilterViewController not found")
            }
            filterVC.delegate = self
        }
        
    }
    
    
    
    

    
}



extension CountryListViewController: FilterDelegate {
    
    func filterData(_ filter: String) {

        self.countryListViewModel?.filterCountry(filter) { data in
            updateHintText(filter, data)
            DispatchQueue.main.async {
                self.CountryListTable.reloadData()
                self.hintAnimation(filter, data)
            }
        }
    }
    
    func updateHintText(_ filter: String, _ data: Int) {
        if filter == "" {
            self.hintLabel.text = "All countries: \(data)"
        } else {
            self.hintLabel.text = "\(filter): \(data)"
        }
    }
    
    func hintAnimation(_ filter: String, _ data: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [UIView.AnimationOptions.curveEaseOut], animations: {
            self.hintYPosition.constant = 60
            self.hintView.alpha = 0.8
            self.hintView.superview?.layoutIfNeeded()
        }) { (finished) in
            UIView.animate(withDuration: 0.5, delay: 3, options: [UIView.AnimationOptions.curveEaseOut], animations: {
                self.hintYPosition.constant = -60
                self.hintView.alpha = 0
                self.hintView.superview?.layoutIfNeeded()
            }, completion: nil)
        }
    }
}



