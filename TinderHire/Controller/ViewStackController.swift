//
//  ViewStackController.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 4/12/17.
//  Copyright © 2017 Mauricio Chirino. All rights reserved.
//

import UIKit

class ViewStackController: UIViewController {

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var picImageView: UIImageView!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var skillLabel: UILabel!
    @IBOutlet private weak var thumbsLabel: UILabel!
    
    private var rotationRatio: CGFloat! {
        return (view.frame.width / 2) / 0.3925
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomEmployee()
    }

    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        guard let card = sender.view else {
            return print("Something went wrong with the gesture")
        }
        let pointsMoved = sender.translation(in: view)
        let scale = min(100 / abs(pointsMoved.x), 1)
        card.center = CGPoint(x: view.center.x + pointsMoved.x, y: view.center.y + pointsMoved.y)
        card.transform = CGAffineTransform(rotationAngle: pointsMoved.x / rotationRatio).scaledBy(x: scale,
                                                                                                  y: scale)
        thumbsLabel.text = pointsMoved.x > 0 ? "👍🏽" : "👎🏽"
        thumbsLabel.alpha = abs(pointsMoved.x) / view.center.x

        if sender.state == .ended {
            if card.center.x < 60 {
                removeCardFromScreen(pickedCard: false, card: card)
                return
            } else if card.center.x > view.frame.width - 60 {
                removeCardFromScreen(pickedCard: true, card: card)
                return
            }
            animateCardReposition()
        }
    }
    
    private func removeCardFromScreen(pickedCard: Bool, card: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            card.center = CGPoint(x: pickedCard ? card.center.x + 200 : card.center.x - 200, y: card.center.y + 50)
            card.alpha = 0
        }, completion: { _ in
            self.removeCard()
            self.getRandomEmployee()
            UIView.animate(withDuration: 0.15, animations: {
                self.cardView.alpha = 1
            })
        })
    }
    
    private func animateCardReposition() {
        UIView.animate(withDuration: 0.3, animations: {
            self.removeCard()
        })
    }
    
    private func removeCard() {
        cardView.center = self.view.center
        cardView.transform = .identity
        thumbsLabel.alpha = 0
    }
    
    private func getRandomEmployee() {
        let currentEmployee = EmployeeFactory.getRandom()
        nameLabel.text = currentEmployee.name
        skillLabel.text = currentEmployee.skill
        genderLabel.text = currentEmployee.sex
        picImageView.image = currentEmployee.sex == "M" ? #imageLiteral(resourceName: "Male") : #imageLiteral(resourceName: "Female")
    }
}
