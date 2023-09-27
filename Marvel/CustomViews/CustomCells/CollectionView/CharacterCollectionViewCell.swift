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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(result: Result) {
        self.characterImageView.addCharacterImage(character: result)
        self.cornerRadius = 16
    }
}
