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
        self.cellImageView.image = model.type.image
        if let values = model.values {
            let combinedText = values.joined(separator: " ")
            self.valueLabel.text = combinedText
        } else {
            self.valueLabel.text = nil
        }
        self.typeLabel.text = model.type.title
        self.valueLabel.isHidden = model.type.expandable
        self.dropDownImage.isHidden = !model.type.expandable
    }
}
