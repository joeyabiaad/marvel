//
//  UIView+CornerRadius.swift
//  DoctorC
//
//  Created by Joey Abi Aad on 19/09/2022.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var isCircle: Bool{
        get {
            return self.isCircle
        }
        set {
            if newValue {
                self.clipsToBounds = true
                self.layer.cornerRadius = self.layer.bounds.width/2
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
}
