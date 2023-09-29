//
//  AllCharactersViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 28/09/2023.
//

import UIKit
import Moya
import SwiftyJSON
import SkeletonView

class AllCharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CustomCollectionView!
    
    private var characterlist: [Result] = []
    private var dataFilter: Dataa!
    
    /// pagination
    private var currentPage: Int = 1
    private var isFetchingData: Bool = false
    private let pageSize: Int = 20
    private var hasMoreData: Bool = true
    var lastContentOffset: CGPoint = .zero
    
    private var isLoadingData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeCollectionView()
        self.getAllCharacters(pageIndex: self.currentPage, pageSize: self.pageSize)
    }
    
    // MARK: - Actions
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Collection view

extension AllCharactersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func initializeCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isSkeletonable = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "CharacterCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CharacterCollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.characterlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        let characterIndex = indexPath.section * 2 + indexPath.item
        
        if characterIndex < self.characterlist.count {
            let character = self.characterlist[characterIndex]
            cell.setupCell(result: character)
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = self.collectionView.bounds.width - 32
        return CGSize(width: (totalWidth - 8 - 1) / 2, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // MARK: - Pagination
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.hasMoreData && !self.isLoadingData {
            let triggerIndex = self.characterlist.count - 3
            if indexPath.section >= triggerIndex {
                self.currentPage += 1
                self.isLoadingData = true
                self.getAllCharacters(pageIndex: self.currentPage, pageSize:  self.pageSize)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterIndex = indexPath.section * 2 + indexPath.item
        if characterIndex < self.characterlist.count {
            let character = self.characterlist[characterIndex]
            let vc = CharacterDetailsViewController.instantiate(fromAppStoryboard: .Character)
            vc.character = character
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - APIs

extension AllCharactersViewController {
    
    func getAllCharacters(pageIndex: Int, pageSize: Int) {
        
        let customGradient = SkeletonGradient(baseColor: .gray)
        self.collectionView.showAnimatedGradientSkeleton(usingGradient: customGradient)
        
        self.isLoadingData = true
        
        let provider = MoyaProvider<CharactersService>(plugins: [NetworkLoggerPlugin()])
        provider.request(CharactersService.getAllCharacters(pageIndex: pageIndex, pageSize: pageSize)) { [weak self] (result) in
            guard let self = self else { return }
            
            defer {
                DispatchQueue.main.async {
                    self.collectionView.hideSkeleton()
                }
                self.isLoadingData = false
            }
            
            switch result {
            case let .success(response):
                do {
                    let status = HttpStatus(rawValue: response.statusCode) ?? .none
                    if status.success {
                        let result = try JSONDecoder().decode(CharactersModel.self, from: response.data)
                        let listResponse = result.data?.results ?? []
                        
                        self.characterlist.append(contentsOf: listResponse)
                        
                        if listResponse.count < pageSize {
                            self.hasMoreData = false
                        }
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    } else {
                        let error = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                        self.openInformativePopup(description: error.errors) { _ in
                            self.getAllCharacters(pageIndex: pageIndex, pageSize: pageSize)
                        }
                    }
                } catch {
                    self.openInformativePopup(description: Messages.unexpectedError)
                }
            case .failure(_):
                self.openInformativePopup(description: Messages.noNetwork) { _ in
                    self.getAllCharacters(pageIndex: pageIndex, pageSize: pageSize)
                }
            }
        }
    }
}

// MARK: - Skeleton view load

extension AllCharactersViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CharacterCollectionViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}
