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
        
        @available(iOS 13.0, *)
        static var userInterfaceStyle: UIUserInterfaceStyle {
            get {
                if let interfaceStyle = UserDefaults.standard.value(forKey: SharedKeys.userInterfaceStyle.rawValue) as? Int {
                    return UIUserInterfaceStyle(rawValue: interfaceStyle) ?? .light
                } else {
                    return UIScreen.main.traitCollection.userInterfaceStyle
                }
            }
            set {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: SharedKeys.userInterfaceStyle.rawValue)
            }
        }
    }
    
    struct Shared {
        static var fontSize: FontSize {
            get {
                if let fontSize = UserDefaults.standard.value(forKey: SharedKeys.fontSize.rawValue) as? String {
                    return FontSize(rawValue: fontSize) ?? .regular
                } else {
                    return .regular
                }
            }
            set {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: SharedKeys.fontSize.rawValue)
            }
        }
    }
    
    // MARK: - Colors
    
    struct Colors {
        static let darkRed = UIColor(named: "darkRed")!
        static let bw = UIColor(named: "bw")!
    }
    
    // MARK: - Go to screens
    
    struct Transact {
        
        static func toTestScreen() {
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.windows.first else { return }
                guard let rootViewController = window.rootViewController else { return }
                
                let vc = OnboardingViewController.instantiate(fromAppStoryboard: .Onboarding)
                vc.view.frame = rootViewController.view.frame
                vc.view.layoutIfNeeded()
                window.rootViewController = vc
            })
        }
        
        static func toHomeScreen() {
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.windows.first else { return }
                guard let rootViewController = window.rootViewController else { return }
                
                let storyboard = UIStoryboard(name: "Home", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController")
                vc.view.frame = rootViewController.view.frame
                vc.view.layoutIfNeeded()
                window.rootViewController = vc
            })
        }
    }
}
