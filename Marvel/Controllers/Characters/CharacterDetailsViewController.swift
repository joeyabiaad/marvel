//
//  CharacterDetailsViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 27/09/2023.
//

import UIKit
import Moya
import SwiftyJSON

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentParentView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageTapView: UIView!
    @IBOutlet weak var contentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentMarginConstraint: NSLayoutConstraint!
    
    private var contentHeight: CGFloat = 0
    private var detailsList: [CharacterDetails] = []
    
    internal var character: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentHeight = self.contentParentView.bounds.height
        self.initializeTableView()
        self.characterImageView.addCharacterImage(character: character)
        self.titleLabel.text = self.character?.name
        self.setupData()
    }
    
    private func setupData() {
        if let comicsItems = self.character?.comics?.items {
            let comicsNames = comicsItems.compactMap { $0.name }
            self.detailsList.append(CharacterDetails(type: .comics, values: comicsNames))
            
        }
        self.detailsList.append(CharacterDetails(type: .events, values: ["test"], title: "Events"))
        self.detailsList.append(CharacterDetails(type: .series, values: ["test"], title: "Series"))
        self.detailsList.append(CharacterDetails(type: .stories, values: ["test"], title: "Stories"))
    }
    
    private func reloadData() {
//        self.setupData()
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table View

extension CharacterDetailsViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    private func initializeTableView() {
        let nib = UINib(nibName: "CharacterDetailsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CharacterDetailsTableViewCell")
        let nib2 = UINib(nibName: "AboutCollectionTableViewCell", bundle: nil)
        self.tableView.register(nib2, forCellReuseIdentifier: "AboutCollectionTableViewCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .clear
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        self.tableView.contentInset = UIEdgeInsets(top: self.contentHeight, left: 0, bottom: 24, right: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("\(self.detailsList.count)")
        return self.detailsList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let characterDetails = self.detailsList[section]
        
        if section >= self.detailsList.count { return nil }
        let header = self.tableView.dequeueReusableCell(withIdentifier: "CharacterDetailsTableViewCell") as! CharacterDetailsTableViewCell
        header.setupCell(model: self.detailsList[section])
        
        if characterDetails.type.expandable {
            let tap = UITapGestureRecognizer(target: self, action: #selector(headerPressed(sender:)))
            header.isUserInteractionEnabled = true
            header.dropDownImage.tag = 1000 + section
            header.tag = 100 + section
            header.addGestureRecognizer(tap)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let charachterDetails = self.detailsList[section]
        switch charachterDetails.type {
        case .comics:
            return charachterDetails.isExpanded ? (self.character?.comics?.items ?? []).count:0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let charachterDetails = self.detailsList[indexPath.section]
        switch charachterDetails.type {
        default:
            return 48
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCollectionTableViewCell", for: indexPath) as! AboutCollectionTableViewCell
        
        let characterDetails = self.detailsList[indexPath.section]
        switch characterDetails.type {
        case .comics:
            if let values = characterDetails.values {
                ///Get the specific comic title
                let comicTitle = values[indexPath.row]
                ///Set the comic title in the label
                cell.descriptionLabel.text = comicTitle
            }
            cell.selectionStyle = .none
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCollectionTableViewCell", for: indexPath) as! AboutCollectionTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    // MARK: - Header pressed
    
    @objc func headerPressed(sender: UIGestureRecognizer) {
        let section = (sender.view?.tag ?? 100) - 100
        
        //        let indexPaths: [IndexPath] = [IndexPath(row: 0, section: section)]
        
        if self.detailsList[section].isExpanded {
            /// close
            self.detailsList[section].isExpanded = false
            //            self.tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            /// open
            self.detailsList[section].isExpanded = true
            //            self.tableView.insertRows(at: indexPaths, with: .fade)
        }
        /// arrow
        if let imageViewOfSection = self.view.viewWithTag(1000 + section) as? UIImageView {
            imageViewOfSection.image = self.detailsList[section].isExpanded ? UIImage(named: "arrowUp"):UIImage(named: "arrowDown")
            imageViewOfSection.tintColor = .white
        }
        self.reloadData()
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

struct CharacterDetails {
    var isExpanded: Bool!
    var type: CharacterDetailsType!
    var values: [String]?
    var title: String?
    
    init(type: CharacterDetailsType,values: [String]? = nil, title: String? = nil) {
        self.isExpanded = false
        self.type = type
        self.values = values
        self.title = title
    }
}

enum CharacterDetailsType {
    case comics
    case events
    case series
    case stories
    
    var title: String {
        switch self {
        case .comics:
            return "Comics"
        case .events:
            return "Events"
        case .series:
            return "Series"
        case .stories:
            return "Stories"
        }
    }
    
    var expandable: Bool {
        switch self {
        default:
            return true
        }
    }
}
