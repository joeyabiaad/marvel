//
//  SettingsViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var settings: [SettingsOptions] {
        return [
            .init(type: .appearance),
            .init(type: .font)
            ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
    }
    
    // MARK: - Actions
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Font Size
    
    private func openActionSheet() {
        /// do not open if iPad
//        if UIDevice.current.userInterfaceIdiom == .pad {return}

        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
       actionSheet.view.tintColor = Constants.Colors.darkRed
    
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelActionButton)
        let regular = UIAlertAction(title: FontSize.regular.title, style: .default) { [weak self] _ in
            Constants.Shared.fontSize = FontSize.regular
            self?.tableView.reloadData()
        }
        actionSheet.addAction(regular)
        let large = UIAlertAction(title: FontSize.large.title, style: .default) { [weak self] _ in
            Constants.Shared.fontSize = FontSize.large
            self?.tableView.reloadData()
        }
        actionSheet.addAction(large)
        let veryLarge = UIAlertAction(title: FontSize.veryLarge.title, style: .default) { [weak self] _ in
            Constants.Shared.fontSize = FontSize.veryLarge
            self?.tableView.reloadData()
        }
        actionSheet.addAction(veryLarge)
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = self.view.bounds
        }
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
        actionSheet.popoverPresentationController?.permittedArrowDirections = []
        self.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: - Table View

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func initializeTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "SettingsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "SettingsTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        let item = settings[indexPath.row]
        cell.setupCell(item: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < settings.count {
            let option = settings[indexPath.row]
            switch option.type {
            case .font:
                self.openActionSheet()
            default:
                if let vc = option.type.vc {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
}

struct SettingsOptions {
    var type: Settings
    
    init(type: Settings) {
        self.type = type
    }
}

enum Settings {
    case appearance
    case font
    
    var title: String {
        switch self {
        case .appearance:
            return "Appearance"
        case .font:
            return "Font"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .appearance:
            return UIImage(named: "brightness")
        case .font:
            return UIImage(named: "brightness")
        }
    }

    var image2: UIImage? {
        switch self {
        case .appearance:
            return UIImage(named: "rightArrow-black")
        case .font:
            return UIImage(named: "dropDown-black")
        }
    }
    var vc: UIViewController? {
        switch self {
        case .appearance:
            let vc = ThemeViewController.instantiate(fromAppStoryboard: .Settings)
            return vc
        default:
            return nil
        }
    }
}

enum FontSize: String {
    case regular
    case large
    case veryLarge
    
    var fontSize: CGFloat {
        switch self {
        case .regular:
            return 16
        case .large:
            return 20
        case .veryLarge:
            return 30
        }
    }
    
    var title: String {
        switch self {
        case .regular:
            return "Regular"
        case .large:
            return "Large"
        case .veryLarge:
            return "Very Large"
        }
    }
}
