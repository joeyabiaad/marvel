//
//  OnboardingCollectionViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(onboardingTips: OnboardingTips) {
        self.titleLabel.text = onboardingTips.title
        self.descriptionLabel.text = onboardingTips.description
}
}
