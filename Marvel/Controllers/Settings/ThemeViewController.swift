//
//  ThemeViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @available(iOS 13.0, *)
    private var themeOption: [SettingsOption] {
        get {
            let userInterfaceStyle = Constants.Static.userInterfaceStyle
            return [
                .init(type: .unspecified, isOn: Theme.unspecified.userInterface == userInterfaceStyle),
                .init(type: .light, isOn: Theme.light.userInterface == userInterfaceStyle),
                .init(type: .dark, isOn: Theme.dark.userInterface == userInterfaceStyle)
            ]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
    }
    
    // MARK: - User interface style
    
    @available(iOS 13.0, *)
    private func changeUserInterfaceStyle(userInterfaceStyle: UIUserInterfaceStyle) {
        Constants.Static.userInterfaceStyle = userInterfaceStyle
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = userInterfaceStyle
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table View

extension ThemeViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func initializeTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let nib = UINib(nibName: "ThemeTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ThemeTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if #available(iOS 13.0, *) {
            return themeOption.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeTableViewCell", for: indexPath) as! ThemeTableViewCell
        if #available(iOS 13.0, *) {
            let themeOption = themeOption[indexPath.row]
            cell.setupSwitchCell(title: themeOption.type.title ?? "", selected: themeOption.isOn)
            cell.statusChanged = { [weak self] isOn in
                self?.changeUserInterfaceStyle(userInterfaceStyle: themeOption.type.userInterface)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

struct SettingsOption {
    var type: Theme
    var isOn: Bool = false
    
    init(type: Theme, isOn: Bool) {
        self.type = type
        self.isOn = isOn
    }
}

enum Theme {
    case unspecified
    case light
    case dark
    
    var title: String? {
        switch self {
        case .unspecified:
            return "SystemDefaults"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
    
    @available(iOS 13.0, *)
    var userInterface: UIUserInterfaceStyle {
        switch self {
        case .unspecified:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
