//
//  FacilityOptionTableViewCell.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import UIKit

class FacilityOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionButton: UIButton!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var optionLabel: UILabel!
    //    var optionSelected: ((FacilityOption) -> ())?
    
    var viewModel: FacilityViewModel?
    var option: FacilityOption?
    var facility: Facility?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupLayout()
    }
    
    // MARK: Private functions
    private func setupLayout() {
        optionButton.setImage(.init(named: "blank-check-box"), for: .normal)
        optionButton.setImage(.init(named: "check-box"), for: .selected)
        optionButton.setImage(.init(named: "disabled"), for: .disabled)
    }
    
    private func updateData() {
        guard let option = option else { return }
        
        optionLabel.text = "\(option.name)"
        iconImageView.image = UIImage(named: option.icon ?? "")
        optionButton.isSelected = option.isSelected
        optionButton.isEnabled = !option.isDisabled
        
    }
    
    // MARK: Public functions
    
    func setViewModel(viewModel: FacilityViewModel, option: FacilityOption, facility: Facility) {
        self.viewModel = viewModel
        self.option = option
        self.facility = facility
        
        updateData()
    }
}
