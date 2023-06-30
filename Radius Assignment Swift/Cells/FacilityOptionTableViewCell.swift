//
//  FacilityOptionTableViewCell.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import UIKit

class FacilityOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionButton: UIButton!
    
//    var optionSelected: ((FacilityOption) -> ())?
    
    var viewModel: FacilityViewModel?
    var option: FacilityOption?
    var facility: Facility?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Private functions
    private func setupLayout() {
        optionButton.setImage(.init(named: "blank-check-box"), for: .normal)
        optionButton.setImage(.init(named: "check-box"), for: .selected)
        optionButton.setImage(.init(named: "disabled"), for: .disabled)
    }
    
    private func updateData() {
        guard let option = option else { return }
        
        optionButton.setTitle("\(option.name)", for: .normal)
        optionButton.isSelected = option.selected ?? false
        optionButton.isEnabled = !(option.disable ?? false)
        
    }
    
    // MARK: Public functions
    
    func setViewModel(viewModel: FacilityViewModel, option: FacilityOption, facility: Facility) {
        self.viewModel = viewModel
        self.option = option
        self.facility = facility
        
        updateData()
    }
    
    // MARK: Actions
    
    @IBAction func handleOptionButtonTap(_ sender: Any) {
        guard let option = option, let facility = facility else { return }
        
//        optionButton.isSelected = !optionButton.isSelected
        
        viewModel?.addOrRemoveFacilityOption(option: option, from: facility)
    }
}
