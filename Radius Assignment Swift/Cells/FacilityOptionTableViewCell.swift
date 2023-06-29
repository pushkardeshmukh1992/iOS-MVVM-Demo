//
//  FacilityOptionTableViewCell.swift
//  Radius Assignment Swift
//
//  Created by Pushkar Deshmukh on 29/06/23.
//

import UIKit

class FacilityOptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupLayout() {
        optionButton.setImage(.init(named: "blank-check-box"), for: .normal)
        optionButton.setImage(.init(named: "check-box"), for: .selected)
    }
    
}
