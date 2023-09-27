//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 27/09/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nftImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentParentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageTapView: UIView!
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentMarginConstraint: NSLayoutConstraint!
    
    private var contentHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentHeight = self.contentParentView.bounds.height
        self.initializeTableView()
    }
    
    // MARK: - Actions
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table View

extension CharacterDetailsViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    private func initializeTableView() {
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterTableViewCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.tableView.contentInset = UIEdgeInsets(top: self.contentHeight, left: 0, bottom: 24, right: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            var yPosition = scrollView.contentOffset.y
            /// adjust based on content inset
            yPosition += self.contentHeight
            self.scaleViews(yPosition: yPosition)
        }
    }
    
    private func scaleViews(yPosition: CGFloat) {
        
        /// scale
        var scale = yPosition / self.contentHeight
        scale = scale > 1 ? 1:scale
        
        /// margin
        /// y = 0 --> normal state
        /// margin = 16
        /// top margin = 24
        /// radius = 12
        ///
        /// y = content height -> max state
        /// margin = (width - 48) / 2
        /// top margin = -48
        /// radius = 6
        
        /// margin
        let maxMargin: CGFloat = (Constants.Static.screenWidth - 48) / 2
        let minMargin: CGFloat = 16
        let marginMaxDiff = (maxMargin - minMargin)
        var margin = minMargin + (marginMaxDiff * scale)
        margin = margin < 8 ? 8:margin
        self.contentMarginConstraint.constant = margin
        
        /// top margin
        let startingTopMargin: CGFloat = 24
        let topMarginMaxDiff: CGFloat = 72
        let topMargin = startingTopMargin - (topMarginMaxDiff * scale)
        self.contentTopConstraint.constant = topMargin
        
        /// radius
        let startingRadius: CGFloat = 12
        let minRadius: CGFloat = 6
        let radiusDiff: CGFloat = startingRadius - minRadius
        self.contentView.cornerRadius = startingRadius - (radiusDiff * scale)
        
        self.view.layoutIfNeeded()
    }
}
