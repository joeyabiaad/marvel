//
//  UIImageExtension.swift
//  Marvel
//
//  Created by Joey Abi Aad on 27/09/2023.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    
    func addCharacterImage(character: Result?, completionHandler: SingleResult<Bool>? = nil) {
        guard let character = character else {
            completionHandler?(false)
            return
        }

        if var thumbnailPath = character.thumbnail?.path,
           let thumbnailExtension = character.thumbnail?.extension {
            
            // Check if the URL starts with "http://"
            if thumbnailPath.lowercased().hasPrefix("http://") {
                // Replace "http://" with "https://"
                thumbnailPath = thumbnailPath.replacingOccurrences(of: "http://", with: "https://")
            }
            
            // Construct the secure (HTTPS) URL
            let imageUrlString = "\(thumbnailPath).\(thumbnailExtension)"
            
            if let imageUrl = URL(string: imageUrlString) {
                print("\(imageUrl)")
                // Start animation (assuming you're using a loading animation)
    //            self.isSkeletonable = true
    //            self.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: Constants.Colors.headerGray), animation: nil, transition: .crossDissolve(0.2))
    //            self.startSkeletonAnimation()
    //
                // Set the image using an image loading library like SDWebImage
                self.sd_setImage(with: imageUrl) { _, _, _, _ in
                    // Stop animation when image loading is complete
    //                self.stopSkeletonAnimation()
    //                self.hideSkeleton()
                    completionHandler?(true)
                }
            }
        } else {
            // No valid thumbnail information found in the NFT, clear the image view
            self.image = nil
            completionHandler?(false)
        }
    }
}
