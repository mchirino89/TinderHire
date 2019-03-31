//
//  CardView.swift
//  TinderHire
//
//  Created by Mauricio Chirino on 30/03/2019.
//  Copyright © 2019 Mauricio Chirino. All rights reserved.
//

import UIKit

protocol ViewStackRendarable: class {
    func renewval()
}

class CardView: ReusableView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var picImageView: UIImageView!
    @IBOutlet private weak var genderLabel: UILabel!
    @IBOutlet private weak var skillLabel: UILabel!
    @IBOutlet private weak var thumbsLabel: UILabel!

    weak var delegate: ViewStackRendarable?

    override func xibName() -> String {
        return "CardView"
    }

    func setInfo(basedOn currentEmployee: EmployeeCV) {
        nameLabel.text = currentEmployee.name
        skillLabel.text = currentEmployee.skill
        genderLabel.text = currentEmployee.sex
        picImageView.image = currentEmployee.sex == "M" ? #imageLiteral(resourceName: "Male") : #imageLiteral(resourceName: "Female")
    }

    func toggleSelection(for pointsMoved: CGPoint, from center: CGPoint, and rotation: CGFloat) {
        let scale = min(100 / abs(pointsMoved.x), 1)
        self.center = CGPoint(x: center.x + pointsMoved.x, y: center.y + pointsMoved.y)
        self.transform = CGAffineTransform(rotationAngle: pointsMoved.x / rotation).scaledBy(x: scale, y: scale)
        thumbsLabel.text = pointsMoved.x > 0 ? "👍🏽" : "👎🏽"
        thumbsLabel.alpha = abs(pointsMoved.x) / center.x
    }

    func removeFromScreen(pickedCard: Bool, at point: CGPoint) {
        UIView.animateKeyframes(withDuration: 0.45, delay: 0, options: [.calculationModeCubic], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3/0.45, animations: {
                self.center = CGPoint(x: pickedCard ? self.center.x + 200 : self.center.x - 200,
                                      y: self.center.y + 50)
                self.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.15/0.45, relativeDuration: 0.3/0.45, animations: {
                self.alpha = 1
            })
        }, completion: { _ in
            self.remove(from: point)
            self.delegate?.renewval()
        })
    }

    func remove(from point: CGPoint) {
        self.center = point
        self.transform = .identity
        thumbsLabel.alpha = 0
    }

}
