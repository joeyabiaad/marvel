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
        
//        // Assuming you have a UIImageView named imageView and a URL for the image.
//        if let imageUrl = URL(string: "https://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg") {
//            characterImageView.sd_setImage(with: imageUrl, completed: { (image, error, cacheType, imageUrl) in
//                if let error = error {
//                    // Handle the error, such as showing a placeholder image or displaying an error message.
//                    print("Error loading image: \(error.localizedDescription)")
//                } else {
//                    // Image loaded successfully, and it's now displayed in imageView.
//                }
//            })
//        }
        // Initialization code
//    }
}
   
    func setupCell(result: Result) {
        self.characterImageView.addCharacterImage(character: result)
        self.cornerRadius = 16
    }
}
