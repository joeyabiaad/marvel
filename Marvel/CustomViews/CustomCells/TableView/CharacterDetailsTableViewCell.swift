//
//  CharacterDetailsTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad on 27/09/2023.
//

import UIKit

class CharacterDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    internal func setupCell(model: CharacterDetails) {
//        self.cellImageView.image = model.type.image
        if let values = model.values {
            let combinedText = values.joined(separator: " ") // Join the values with a space separator
            self.valueLabel.text = combinedText
        } else {
            self.valueLabel.text = nil // Handle the case when values is nil
        }

//        self.valueLabel.text = model.values
        self.typeLabel.text = model.type.title
        self.valueLabel.isHidden = model.type.expandable
//        self.valueLabel.textColor = model.type.valueTextColor
        self.dropDownImage.isHidden = !model.type.expandable
    }
}
