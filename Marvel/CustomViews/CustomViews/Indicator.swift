//
//  Indicator.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

class Indicator: UIView {
    
    private lazy var stackView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    internal var numberOfIndicators = 0 {
        didSet {
            drawFeatureIndicator()
        }
    }
    private(set) var selectedIndex = 0 {
        didSet {
            for (index,_) in indicators.enumerated() {
                UIView.animate(withDuration: 0.2) {
                    self.indicators[index].view.backgroundColor = (index == self.selectedIndex) ? self.selectedIndicatorColor:self.indicatorColor
                }
            }
        }
    }
    internal var indexPosition: Double = 0 {
        didSet {
            self.selectedIndex = Int(round(indexPosition))
            self.changeIndicatorsWidth(indexPosition)
        }
    }
    
    @IBInspectable internal var separatorSize: CGFloat = 10 {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    @IBInspectable internal var indicatorHeight: CGFloat = 10 {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    @IBInspectable internal var indicatorWidth: CGFloat = 10 {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    @IBInspectable internal var selectedIndicatorWidth: CGFloat = 28 {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    @IBInspectable internal var indicatorColor: UIColor = .lightGray {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    @IBInspectable internal var selectedIndicatorColor: UIColor = .white {
        didSet {
            self.drawFeatureIndicator()
        }
    }
    private var indicatorCornerRadius: CGFloat {
        get {
            return self.indicatorHeight / 2
        }
    }
    
    private var indicators: [(view: UIView, widthConstraint: NSLayoutConstraint)] = []
    
    override func awakeFromNib() {
        self.createStackView()
        self.drawFeatureIndicator()
    }
    
    private func createStackView() {
        self.addSubview(self.stackView)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
//        let horizontalConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let verticalConstraint = self.stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let heightConstraint = self.stackView.heightAnchor.constraint(equalToConstant: 8)
        let leadingConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        self.addConstraints([leadingConstraint, verticalConstraint, heightConstraint])
    }
    
    private func drawFeatureIndicator() {
        /// remove old views
        self.stackView.subviews.forEach({ $0.removeFromSuperview() })
        self.indicators = []
        /// draw views
        for i in 0..<numberOfIndicators {
            let indicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            indicatorView.cornerRadius = self.indicatorCornerRadius
            indicatorView.backgroundColor = selectedIndex == i ? self.selectedIndicatorColor:self.indicatorColor
            let width: CGFloat = selectedIndex == i ? self.selectedIndicatorWidth:self.indicatorWidth
            
            self.stackView.addSubview(indicatorView)
            
            let topConstraint = indicatorView.topAnchor.constraint(equalTo: self.stackView.topAnchor)
            let bottomConstraint = indicatorView.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor)
            let heightConstraint = indicatorView.heightAnchor.constraint(equalToConstant: self.indicatorHeight)
            let widthConstraint = indicatorView.widthAnchor.constraint(equalToConstant: width)
            
            self.stackView.addConstraints([topConstraint, bottomConstraint, heightConstraint, widthConstraint])
            
            self.indicators.append((view: indicatorView, widthConstraint: widthConstraint))
            
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                /// first item
                /// related to view
                let leadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)
                self.stackView.addConstraints([leadingConstraint])
            } else {
                /// related to item i - 1
                let leadingConstraint = indicatorView.leadingAnchor.constraint(equalTo: self.indicators[i - 1].view.trailingAnchor, constant: self.separatorSize)
                self.stackView.addConstraints([leadingConstraint])
                
                if i == (numberOfIndicators - 1) {
                    /// last item
                    let trailingConstraint = indicatorView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
                    self.stackView.addConstraints([trailingConstraint])
                }
            }
        }
    }
    
    private func changeIndicatorsWidth(_ indexPosition: Double) {
        let sizeDiff: CGFloat = self.selectedIndicatorWidth - self.indicatorWidth
        
        let indicatorAIndex: Double = floor(indexPosition)
        let indicatorBIndex: Double = ceil(indexPosition)
        
        let scaleA: Double = 1 - (indexPosition - indicatorAIndex)
        let scaleB: Double = 1 - (indicatorBIndex - indexPosition)
        
        for (index, _) in self.indicators.enumerated() {
            if index == Int(indicatorAIndex) {
                self.indicators[index].widthConstraint.constant = self.indicatorWidth + (sizeDiff * scaleA)
            } else if index == Int(indicatorBIndex) {
                self.indicators[index].widthConstraint.constant = self.indicatorWidth + (sizeDiff * scaleB)
            } else {
                self.indicators[index].widthConstraint.constant = self.indicatorWidth
            }
        }
        self.layoutIfNeeded()
    }
}
