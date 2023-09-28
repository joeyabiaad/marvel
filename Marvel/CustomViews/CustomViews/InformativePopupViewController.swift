//
//  InformativePopupViewController.swift
//  Athkar
//
//  Created by Joey Abi Aad on 12/14/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class InformativePopupViewController: UIViewController {

    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    public typealias ButtonAction = () -> Void
    public var actionButtonPressed: ButtonAction?
    public var popupDismissed: ButtonAction?

    public var popupDescription: String = ""
    public var actionButtonTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        /// dismiss on tap
        let tap = UITapGestureRecognizer(target: self, action: #selector(onBackgroundPressed))
        self.backView.isUserInteractionEnabled = true
        self.backView.addGestureRecognizer(tap)

        /// view
        popupView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleDismiss)))

        /// setup view
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIDevice.vibrate()

        /// alpha
        self.alphaView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.alphaView.alpha = 0.4
        }
    }

    private func setupView() {
        self.descriptionLabel.text = self.popupDescription
//        self.actionButton.backgroundColor = self.actionButtonColor
        self.actionButton.setTitle(self.actionButtonTitle, for: .normal)
    }

    // MARK: - Actions

    @IBAction func onActionPressed(_ sender: Any) {
        self.actionButtonPressed?()
        dismiss(animated: true)
    }

    @objc func onBackgroundPressed() {
        dismiss(animated: true)
    }

    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
}
