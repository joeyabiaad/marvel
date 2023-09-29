//
//  SettingsViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var settings: [Settings] {
        get {
            var temp: [Settings] = []
            temp.append(contentsOf: [
                .appearance
            ])
            return temp
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeTableView()
    }
    
    // MARK: - Actions
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            if let vc = option.vc {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

enum Settings {
    case appearance
    
    var title: String {
        switch self {
        case .appearance:
            return "Appearance"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .appearance:
            return UIImage(named: "brightness")
        }
    }
    
    var vc: UIViewController? {
        switch self {
        case .appearance:
            let vc = ThemeViewController.instantiate(fromAppStoryboard: .Settings)
            return vc
        }
    }
}
