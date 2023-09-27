//
//  Constants.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import Foundation
import UIKit

class Constants {
    
    struct Static {
        static var screenWidth: CGFloat = UIScreen.main.bounds.width
        static var screenHeight: CGFloat = UIScreen.main.bounds.height
    }
    
    // MARK: - Go to screens
    
    struct Transact {
        
        static func toTestScreen() {
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.windows.first else { return }
                guard let rootViewController = window.rootViewController else { return }
                
                let vc = CharacterDetailsViewController.instantiate(fromAppStoryboard: .Character)
                vc.view.frame = rootViewController.view.frame
                vc.view.layoutIfNeeded()
                window.rootViewController = vc
            })
        }
        
        static func toHomeScreen() {
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.windows.first else { return }
                guard let rootViewController = window.rootViewController else { return }
                
                let vc = HomeViewController.instantiate(fromAppStoryboard: .Home)
                vc.view.frame = rootViewController.view.frame
                vc.view.layoutIfNeeded()
                window.rootViewController = vc
            })
        }
    }
}
