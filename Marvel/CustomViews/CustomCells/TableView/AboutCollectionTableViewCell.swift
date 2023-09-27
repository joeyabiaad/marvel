//
//  AboutCollectionTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad on 27/09/2023.
//

import UIKit

class AboutCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
