//
//  ViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gifImage: UIImageView!
    
    let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dispatchGroup.enter()
        self.gifImage.loadGifOnce(name: "Marvel_Logo_Final", animationSpeed: 1)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.4) {
            self.dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            let animationDuration = 1.4
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                Constants.Transact.toTestScreen()
            }
        }
    }
}
