//
//  HeaderTableViewCell.swift
//  Marvel
//
//  Created by Joey Abi Aad  on 26/09/2023.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var viewAllView: UIView!
    @IBOutlet weak var viewAllLabel: UILabel!
    
    internal var viewAllPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewAllLabel.text = "View All"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onViewAllPressed))
        self.viewAllView.isUserInteractionEnabled = true
        self.viewAllView.addGestureRecognizer(tap)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onViewAllPressed() {
        self.viewAllPressed?()
    }
}
