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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        facilityViewModel.getFacilities { [weak self] response in
            print(response)
            self?.tableView.reloadData()
        }
    }
    
    private func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FacilityOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "FacilityOptionTableViewCell")
        
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
        
        let option = result.facilities[indexPath.section].options[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FacilityOptionTableViewCell", for: indexPath) as? FacilityOptionTableViewCell else { return UITableViewCell() }
        cell.optionButton.setTitle("\(option.name)", for: .normal)
        
        return cell
    }
}

