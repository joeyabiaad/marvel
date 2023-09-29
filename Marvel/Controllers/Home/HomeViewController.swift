//
//  HomeViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit
import Moya
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionPageControl: UIPageControl!
    
    private var sliderList: [SliderImages] = [SliderImages(image: UIImage(named: "marvel")),SliderImages(image: UIImage(named: "marvel2")), SliderImages(image: UIImage(named: "marvel3"))]
    
    private var characterlist: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCollectionView()
        self.startTimer()
        self.initializeTableView()
        self.getCharacters()
    }
    @IBAction func settingsPressed(_ sender: Any) {
        let vc = SettingsViewController.instantiate(fromAppStoryboard: .Settings)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Delegate

extension HomeViewController: CharacterDelegate {
    
    func characterPressed(_ character: Result) {
        let vc = CharacterDetailsViewController.instantiate(fromAppStoryboard: .Character)
        vc.character = character
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Collection view

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func initializeCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let nib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "SliderCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sliderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        let sliderImages = sliderList[indexPath.row]
        cell.setupCell(sliderImage: sliderImages)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.Static.screenWidth, height: self.collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if collectionView == self.collectionView {
            let pageWidth = collectionView.frame.size.width
            let index = scrollView.contentOffset.x / pageWidth
            
            self.collectionPageControl.currentPage = Int(index)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            let pageWidth = collectionView.frame.size.width
            let position = scrollView.contentOffset.x / pageWidth
            let index = round(position)
            self.collectionPageControl.currentPage = Int(index)
        }
    }
    
    // MARK: - Auto scroll features
    
    private func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell() {
        /// get cell size
        let cellSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        /// get current content Offset of the Collection view
        let contentOffset = self.collectionView.contentOffset
        /// scroll to next cell
        let maxX = self.view.frame.width * CGFloat(self.sliderList.count - 1)
        
        if contentOffset.x == maxX {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
        } else {
            collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
        }
    }
}

// MARK: - Table view

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func initializeTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        let headerNib = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        self.tableView.register(headerNib, forCellReuseIdentifier: "HeaderTableViewCell")
        let characterNib = UINib(nibName: "CharactersCollectionTableViewCell", bundle: nil)
        self.tableView.register(characterNib, forCellReuseIdentifier: "CharactersCollectionTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
            header.headerLabel.text = "Characters"
        header.viewAllPressed = { [weak self] in
            guard let self = self else { return }
            let vc = AllCharactersViewController.instantiate(fromAppStoryboard: .Character)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(self.characterlist.count)")
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 268
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCollectionTableViewCell", for: indexPath) as! CharactersCollectionTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.character = self.characterlist
        return cell
    }
}

// MARK: - APIs

extension HomeViewController {
    
    func getCharacters() {
        let provider = MoyaProvider<CharactersService>(plugins: [NetworkLoggerPlugin()])
        
        provider.request(CharactersService.getCharacters) { [weak self] (result) in
            guard let self = self else { return }
            defer {
            }
            switch result {
            case let .success(response):
                do {
                    #if DEBUG
                    let json = try JSON(data: response.data)
                    print(json)
                    print(response.statusCode)
                    #endif
                    let status = HttpStatus(rawValue: response.statusCode) ?? .none
                    if status.success {
                        let result = try JSONDecoder().decode(CharactersModel.self, from: response.data)
                        self.characterlist = result.data?.results ?? []
                        self.tableView.reloadData()
                    } else {
                        let error = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                        self.openInformativePopup(description: error.errors) { _ in
                            self.getCharacters()
                        }
                    }
                } catch {
                    self.openInformativePopup(description: Messages.unexpectedError)
                }
            case .failure(_):
                 self.openInformativePopup(description: Messages.noNetwork) { _ in
                        self.getCharacters()
                    }
            }
        }
    }
}

struct SliderImages {
    var image: UIImage?
}

struct Character {
    var name: String?
}
