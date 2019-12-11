//
//  FilterViewController.swift
//  Wiki Country
//
//  Created by BoFu on 05/12/2019.
//  Copyright © 2019 BoFu. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    func filterData(_ key: String)
}

class FilterViewController: UIViewController {

    var delegate: FilterDelegate?
    private var filterViewModel = FilterViewModel()
    @IBOutlet weak var filterOptionTable: UITableView!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func cleanAction(_ sender: UIButton) {

        if let indexPath = self.filterOptionTable.indexPathForSelectedRow {
            self.filterOptionTable.deselectRow(at: indexPath, animated: false)
        }
        self.filterOptionTable.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        self.filterViewModel.selectedFilter = nil
    }
    @IBAction func saveAction(_ sender: UIButton) {

        if let indexPath = self.filterOptionTable.indexPathForSelectedRow {
            self.delegate?.filterData(filterViewModel.optionAtIndex(indexPath.row).rawValue)
            self.filterViewModel.selectedFilter = Filter.allCases[indexPath.row]
        } else {
            self.delegate?.filterData("")
        }
        if self.filterViewModel.lastSelectedFilter != self.filterViewModel.selectedFilter {
            setTrail()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSelectedFilters()
    }
    
    private func setupUI() {
        navigationItem.hidesBackButton = true
        
        buttonView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        buttonView.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        buttonView.layer.shadowOpacity = 1.0
        buttonView.layer.shadowRadius = 5
        
        cleanButton.layer.cornerRadius = 5
        cleanButton.layer.borderWidth = 1
        cleanButton.layer.borderColor = self.view.tintColor.cgColor
        
        saveButton.backgroundColor = self.view.tintColor
        saveButton.layer.cornerRadius = 5
    }
    
    private func setSelectedFilters() {
        self.filterViewModel.lastSelectedFilter = self.filterViewModel.selectedFilter
        if let selectedFilter = self.filterViewModel.selectedFilter {
            
            guard let index = self.filterViewModel.options.firstIndex(of: selectedFilter) else {
                fatalError("index of selectedFilter not found")
            }
            filterOptionTable.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
        }
        
    }
    
    private func setTrail() {
        UserDefaults.standard.set(true, forKey: "backToTop")
    }
    
}


extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterViewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath)
        cell.textLabel?.text = filterViewModel.optionAtIndex(indexPath.row).rawValue
        
        if self.filterViewModel.selectedFilter == self.filterViewModel.options[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        if let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .checkmark
        }
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
