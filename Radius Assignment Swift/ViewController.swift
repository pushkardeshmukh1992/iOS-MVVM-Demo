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
            self?.tableView.reloadData()
        }
    }
    
    private func setupLayout() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellType", for: indexPath)
        
        cell.textLabel!.text = "Title text"
        
        return cell
    }
}

