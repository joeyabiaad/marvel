//
//  SettingsTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad  on 28/09/2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(item: SettingsOptions) {
        self.itemImageView.image = item.type.image
        self.titleLabel.text = item.type.title
        self.arrowImageView.image = item.type.image2
    }
}
