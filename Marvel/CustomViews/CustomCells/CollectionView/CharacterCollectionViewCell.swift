//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(result: Result) {
        self.characterImageView.addCharacterImage(character: result)
        self.characterName.text = result.name
        self.cornerRadius = 16
    }
}
