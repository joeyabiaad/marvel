//
//  ThemeTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad  on 28/09/2023.
//

import UIKit

class ThemeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkBoxView: CheckBoxView!
    
    internal var statusChanged: SingleResult<Bool>?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkBoxView.statusChanged = { [weak self] isOn in
            guard let self = self else { return }
            self.statusChanged?(isOn)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
    func setupSwitchCell(title: String, selected: Bool) {
        self.titleLabel.text = title
        self.checkBoxView.setOn(selected, animated: false)
    }
}
