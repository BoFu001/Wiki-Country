//
//  CountryListViewController.swift
//  Wiki Country
//
//  Created by BoFu on 05/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {

    @IBOutlet weak var bootAnimationView: UIView!
    @IBOutlet weak var hintView: UIView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hintYPosition: NSLayoutConstraint!
    
    private var countryListViewModel: CountryListViewModel?
    @IBOutlet weak var countryListTable: UITableView!
    
    @IBOutlet weak var noConnectionScreen: UIView!
    @IBOutlet weak var retryButton: UIButton!
    @IBAction func retryButton(_ sender: UIButton) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupUI()
        bootAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkTrail()
    }
    
    private func getData() {

        if let url = URL(string: Constants.GET_COUNTRY_URL) {
            
            Webservice().getCountries(url: url) { countries in
                
                if let countries = countries {
                    self.countryListViewModel = CountryListViewModel(countries)
                    
                    DispatchQueue.main.async {
                        self.countryListTable.reloadData()
                        self.noConnectionScreen.alpha = 0
                    }
                    
                } else {
                    DispatchQueue.main.async {
                        self.noConnectionScreen.alpha = 1
                    }
                }
            }
        }
    }
    
    private func setupUI() {
        countryListTable.rowHeight = UITableView.automaticDimension
        countryListTable.estimatedRowHeight = 120.5
        
        hintView.layer.cornerRadius = 5
        retryButton.layer.cornerRadius = 5
    }
    
    func bootAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.bootAnimationView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.bootAnimationView.alpha = 0
        }
    }
    
    private func checkTrail() {
        let backToTop = UserDefaults.standard.bool(forKey: "backToTop")
        if backToTop {
            UserDefaults.standard.set(false, forKey: "backToTop")
            DispatchQueue.main.async {
                self.countryListTable.setContentOffset(.zero, animated: false)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CountryDetailViewController" {
            
            guard let countryDetailVC = segue.destination as? CountryDetailViewController else {
                fatalError("CountryDetailViewController not found")
            }
            guard let indexPath = self.countryListTable.indexPathForSelectedRow else {
                fatalError("countryListTable.indexPathForSelectedRow not found")
            }
            
            let countryModel = self.countryListViewModel?.countryAtIndex(indexPath.row)
            countryDetailVC.countryModel = countryModel
            

            guard let cell = countryListTable.cellForRow(at: indexPath) as? CountryListTableViewCell else {
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


extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.configure(countryModel, indexPath.row)
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
}


extension CountryListViewController: FilterDelegate {
    
    func filterData(_ filter: String) {

        self.countryListViewModel?.filterCountry(filter) { data in
            updateHintText(filter, data)
            DispatchQueue.main.async {
                self.countryListTable.reloadData()
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
