//
//  CheckBox.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import UIKit

public typealias SelectionClosure = (Bool) -> Void

class CheckBoxView: UIView {
    
    private var imageView = UIImageView()
    private(set) var checked: Bool = false {
        didSet {
            changeStateDesign()
        }
    }
    @IBInspectable var userInteraction: Bool = true {
        didSet {
            self.isUserInteractionEnabled = userInteraction
        }
    }
    @IBInspectable var viewBorderColor: UIColor = Constants.Colors.bw
    
    internal var fillCircle: Bool = false
    
    public var statusChanged: SelectionClosure?
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(CheckBoxView.onViewPressed))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = userInteraction
        drawView()
    }
    
    private func drawView() {
        self.isCircle = true
        imageView = UIImageView(frame: CGRect(x: self.fillCircle ? 0:2, y: self.fillCircle ? 0:2, width: self.bounds.height - (self.fillCircle ? 0:4), height: self.bounds.height - (self.fillCircle ? 0:4)))
        imageView.contentMode = .scaleAspectFit
        imageView.isCircle = true
        imageView.backgroundColor = Constants.Colors.darkRed
        self.borderWidth = 1
        self.borderColor = .gray
        self.backgroundColor = .clear
        self.addSubview(imageView)
        self.changeStateDesign()
    }
    
    func changeStateDesign(animated: Bool = true) {
        self.imageView.backgroundColor = self.checked ? Constants.Colors.darkRed:.gray
        self.borderColor = self.checked ? viewBorderColor:.gray
        //        UIView.animate(withDuration: animated ? 0.3:0) {
        //            self.imageView.alpha = self.checked ? 1:0
        //        }
    }
    
    @objc func onViewPressed() {
        self.checked.toggle()
        self.statusChanged?(self.checked)
    }
    
    public func setOn(_ on: Bool, animated: Bool) {
        self.checked = on
        changeStateDesign(animated: animated)
    }
}
