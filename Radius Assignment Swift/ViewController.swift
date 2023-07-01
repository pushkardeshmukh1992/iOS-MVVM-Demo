//
//  ViewController.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import UIKit

class ViewController: UIViewController {
    let facilityViewModel = FacilityViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        facilityViewModel.getFacilities()
        facilityViewModel.didChangeDataSource = { [weak self] in
            self?.tableView.reloadData()
            self?.showErrorIfDataIsEmpty()
        }
    }
    
    private func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FacilityOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "FacilityOptionTableViewCell")
        
    }
    
    private func showErrorIfDataIsEmpty() {
        if let result = facilityViewModel.result, result.facilities.count > 0 {
            tableView.isHidden = false
            errorStackView.isHidden = true
        } else {
            tableView.isHidden = true
            errorStackView.isHidden = false
        }
    }
    
    // MARK: Button actions
    
    @IBAction func handleRetryActionTap(_ sender: Any) {
        facilityViewModel.getFacilities()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let result = facilityViewModel.result else { return 0 }
        
        return result.facilities.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(view.frame.width)
        
        guard let result = facilityViewModel.result else { return nil }
        
        let view = UIView()
        view.frame = .init(x: 0, y: 0, width: view.frame.width, height: 48)
        
        let headerTitle = UILabel()
        headerTitle.text = result.facilities[section].name
        headerTitle.frame = .init(x: 16, y: 16, width: 300, height: 16)
        
        view.addSubview(headerTitle)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = facilityViewModel.result else { return 0 }
        
        return result.facilities[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let result = facilityViewModel.result else { return UITableViewCell() }
        
        let facility = result.facilities[indexPath.section]
        let option = facility.options[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityOptionTableViewCell", for: indexPath) as? FacilityOptionTableViewCell else { return UITableViewCell() }
        cell.setViewModel(viewModel: facilityViewModel, option: option, facility: facility)
        
        
        return cell
    }
}

