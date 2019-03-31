//
//  ViewStackController.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 4/12/17.
//  Copyright © 2017 Mauricio Chirino. All rights reserved.
//

import UIKit

class ViewStackController: UIViewController {

    @IBOutlet private weak var cardView: CardView! {
        didSet {
//            cardView.delegate = self
        }
    }
    private var rotationRatio: CGFloat! {
        return (view.frame.width / 2) / 0.3925
    }
    private weak var delegate: ViewStackRendarable?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.setInfo(basedOn: EmployeeFactory.getRandom())
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else {
            return print("Something went wrong with the gesture")
        }
        let pointsMoved = sender.translation(in: view)
        delegate?.toggleSelection(for: pointsMoved, from: view.center, and: rotationRatio)

        if sender.state == .ended {
            if card.center.x < 60 {
                didPickCard(false)
                return
            } else if card.center.x > view.frame.width - 60 {
                didPickCard(true)
                return
            }
            animateCardReposition()
        }
    }

    private func didPickCard(_ selected: Bool) {
        delegate?.removeFromScreen(pickedCard: selected, at: view.center) {
            self.delegate?.setInfo(basedOn: EmployeeFactory.getRandom())
        }
    }
    
    private func animateCardReposition() {
        UIView.animate(withDuration: 0.3, animations: {
            self.delegate?.remove(from: self.view.center)
        })
    }
}
