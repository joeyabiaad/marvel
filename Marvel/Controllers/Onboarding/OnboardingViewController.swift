//
//  OnboardingViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: Indicator!
    
    private var onboardingTips: [OnboardingTips] = [OnboardingTips(title: "Lorem Ipsum 1", description: "The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."), OnboardingTips(title: "Lorem Ipsum 2", description: "The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."), OnboardingTips(title: "Lorem Ipsum 3", description: "The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."), OnboardingTips(title: "Lorem Ipsum 4", description: "The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicatorView.numberOfIndicators = self.onboardingTips.count
        self.initializeCollectionView()
    }
    
    // MARK: - Action
    
    @IBAction func continuePressed(_ sender: Any) {
        Constants.Transact.toHomeScreen()
    }
}

// MARK: - Collection view

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func initializeCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let nftNib = UINib(nibName: "OnboardingCollectionViewCell", bundle: nil)
        self.collectionView.register(nftNib, forCellWithReuseIdentifier: "OnboardingCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingTips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        let onboardingTips = onboardingTips[indexPath.row]
        cell.setupCell(onboardingTips: onboardingTips)
        return cell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        self.view.layoutIfNeeded()
        let height: CGFloat = self.collectionView.bounds.height
        let width: CGFloat = Constants.Static.screenWidth
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let index = scrollView.contentOffset.x / pageWidth
        self.indicatorView.indexPosition = index
    }
}

struct OnboardingTips {
    var title: String?
    var description: String?
}
