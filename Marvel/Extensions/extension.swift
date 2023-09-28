//
//  extension.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import Foundation
import CommonCrypto
import UIKit
import AudioToolbox

// MARK: - String
extension String {
    
    var md5: String {
        if let data = data(using: .utf8) {
            var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            _ = data.withUnsafeBytes {
                CC_MD5($0.baseAddress, CC_LONG(data.count), &digest)
            }
            return (0..<Int(CC_MD5_DIGEST_LENGTH)).map {
                String(format: "%02x", digest[$0])
            }.joined()
        }
        return ""
    }
}

// MARK: - UIDevice

extension UIDevice {
    
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    
    static func vibrate() {
        AudioServicesPlayAlertSound(1519)
    }
    
    static func strongVibrate() {
        AudioServicesPlayAlertSound(1520)
    }
    
    static func tripleVibration() {
        AudioServicesPlayAlertSound(1521)
    }
}

extension UIViewController {
    
    func openInformativePopup(description: String, completion: ((_ okPressed: Bool) -> Void)? = nil) {
        DispatchQueue.main.async {
            let vc = InformativePopupViewController()
            vc.popupDescription = description
            vc.actionButtonTitle = "Ok"
            vc.modalPresentationStyle = .overFullScreen
            vc.actionButtonPressed = {
                completion?(true)
            }
            vc.popupDismissed = {
                completion?(false)
            }
            self.present(vc, animated: false, completion: {
                vc.popupView.alpha = 1
            })
        }
    }
}
