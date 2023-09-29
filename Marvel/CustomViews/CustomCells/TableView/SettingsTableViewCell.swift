//
//  SettingsTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad  on 28/09/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(item: Settings) {
        self.itemImageView.image = item.image
        self.titleLabel.text = item.title
    }
}
