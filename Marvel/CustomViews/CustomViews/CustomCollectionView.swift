//
//  CustomCollectionView.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import Foundation
import UIKit

class CustomCollectionView: UICollectionView {
    
    @IBInspectable internal var emptyMessage: String = ""
    @IBInspectable internal var emptyBackgroundColor: UIColor = .clear
    
    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        label.text = emptyMessage
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    lazy var emptyView: UIView = {
        self.layoutIfNeeded()
        self.superview?.layoutIfNeeded()
        let y = 0
        var width = (self.bounds.width > Constants.Static.screenWidth) ? Constants.Static.screenWidth:self.bounds.width
        width = width < 100 ? Constants.Static.screenWidth:width
        let view = UIView(frame: CGRect(x: 0, y: y, width: Int(width), height: Int(self.bounds.height) - y))
        view.backgroundColor = emptyBackgroundColor
        view.tag = 99
        view.addSubview(messageLabel)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.9, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.leadingMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.leadingMargin, multiplier: 1, constant: 32)
        let rightConstraint = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.trailingMargin, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.trailingMargin, multiplier: 1, constant: 32)
        let heightConstraint = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.greaterThanOrEqual, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 24)
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint, leftConstraint, rightConstraint, heightConstraint])

        return view
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func reloadData() {
        super.reloadData()
        
        var numberOfItems = 0
        for i in (0..<self.numberOfSections) {
            numberOfItems += self.numberOfItems(inSection: i)
        }
        
        if numberOfItems == 0 {
            /// no data to show
            self.backgroundView = emptyView
        } else {
            self.backgroundView = nil
        }
    }
}
