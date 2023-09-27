//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    
    internal var character: Result? {
        didSet {
            if let character = character {
                self.setupCell(result: character)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(result: Result) {
        self.characterImageView.addCharacterImage(character: result)  { [weak self] _ in
            guard let self = self else { return }
    }
    self.cornerRadius = 16
    }
}
